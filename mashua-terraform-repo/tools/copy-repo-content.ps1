param(
  [Parameter(Mandatory=$true)][string]$SourceUrl,
  [Parameter(Mandatory=$true)][string]$TargetUrl,
  [Parameter(Mandatory=$true)][string]$DestinationFolder,
  [string]$Branch = "main",
  [string]$WorkDir = "$env:TEMP\copy-repo-temp"
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

function Ensure-Dir($p) { if (-not (Test-Path $p)) { New-Item -ItemType Directory -Path $p | Out-Null } }

Ensure-Dir $WorkDir

$srcPath = Join-Path $WorkDir "src"
$tgtPath = Join-Path $WorkDir "tgt"

if (Test-Path $srcPath) { Remove-Item -Recurse -Force $srcPath }
if (Test-Path $tgtPath) { Remove-Item -Recurse -Force $tgtPath }

git clone --depth 1 --branch $Branch $SourceUrl $srcPath
git clone --depth 1 --branch $Branch $TargetUrl $tgtPath

$destFolder = Join-Path $tgtPath $DestinationFolder
if (Test-Path $destFolder) { Remove-Item -Recurse -Force $destFolder }
New-Item -ItemType Directory -Path $destFolder | Out-Null

Get-ChildItem -Force $srcPath | Where-Object { $_.Name -ne ".git" } | ForEach-Object {
  Copy-Item -Recurse -Force $_.FullName $destFolder
}

Push-Location $tgtPath

git add -A

$changes = git status --porcelain
if ([string]::IsNullOrWhiteSpace($changes)) {
  Write-Host "No changes to commit."
  Pop-Location
  exit 0
}

git commit -m "Copy $DestinationFolder from source ($SourceUrl) into branch $Branch"
git push origin $Branch

Pop-Location
Write-Host "Success! Push code into $DestinationFolder in $SourceUrl"



locals {
  product = "knotch"

  // TODO Agregar naming
  loc_abbr = "eu"
  env_abbr_map = {
    development = "dev"
    staging     = "stg"
    production  = "prod"
  }
  env_abbr = local.env_abbr_map[var.env]

  name_prefix        = "kito-${local.env_abbr}-${local.loc_abbr}"
  name_prefix_global = "kito${local.env_abbr}${local.loc_abbr}"

  tags = {
    Environment = var.env
    CreatedBy   = "Infra team"
    CreatedDate = "2026-01-07"
  }
}

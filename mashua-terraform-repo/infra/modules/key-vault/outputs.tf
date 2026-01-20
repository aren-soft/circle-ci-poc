output "id" {
  description = "The Key Vault ID"
  value       = azurerm_key_vault.this.id
}

output "name" {
  description = "The Key Vault name"
  value       = azurerm_key_vault.this.name
}

output "vault_uri" {
  description = "The URI of the Key Vault, used for performing operations on keys and secrets."
  value       = azurerm_key_vault.this.vault_uri
}

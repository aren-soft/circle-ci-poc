output "key_vault_secret_id" {
  description = "The ID of the created Key Vault secret."
  value       = azurerm_key_vault_secret.this.id
}

output "key_vault_secret_version" {
  description = "The version of the created Key Vault secret."
  value       = azurerm_key_vault_secret.this.version
}

output "secret_name" {
  description = "The name of the stored Key Vault secret"
  value       = azurerm_key_vault_secret.this.name
}

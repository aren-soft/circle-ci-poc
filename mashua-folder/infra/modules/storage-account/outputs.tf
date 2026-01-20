output "name" {
  description = "The name of the resoruce created."
  value       = azurerm_storage_account.this.name
}

output "id" {
  description = "The id of the resource created."
  value       = azurerm_storage_account.this.id
}

output "primary_connection_string" {
  description = "The primary connection string of the storage account created."
  value       = azurerm_storage_account.this.primary_connection_string
}

output "primary_access_key" {
  description = "The primary access key of the storage account created."
  value       = azurerm_storage_account.this.primary_access_key
}

output "database_id" {
  description = "The ID of the created database"
  value       = azurerm_postgresql_flexible_server_database.this.id
}

output "database_name" {
  description = "The name of the created database"
  value       = azurerm_postgresql_flexible_server_database.this.name
}

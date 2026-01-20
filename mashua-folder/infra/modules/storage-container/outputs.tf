output "id" {
  description = "The id of the created resource."
  value       = azurerm_storage_container.this.id
}

output "name" {
  description = "The name of the created resource."
  value       = azurerm_storage_container.this.name
}

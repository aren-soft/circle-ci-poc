output "id" {
  value       = azurerm_container_registry.this.id
  description = "The ID of the Azure Container Registry."
}

output "name" {
  value       = azurerm_container_registry.this.name
  description = "The name of the Azure Container Registry."
}

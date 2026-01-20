output "id" {
  description = "Application Load Balancer ID"
  value       = azurerm_application_load_balancer.this.id
}

output "name" {
  description = "Application Load Balancer name"
  value       = azurerm_application_load_balancer.this.name
}

output "id" {
  value       = azurerm_managed_redis.this.id
  description = "Redis resource ID"
}

output "name" {
  value       = azurerm_managed_redis.this.name
  description = "Redis name"
}

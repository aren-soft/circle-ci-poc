output "names" {
  description = "List of names of the private DNS zones created."
  value       = [for zone in azurerm_private_dns_zone.this : zone.name]
}

output "ids" {
  description = "List of IDs of the private DNS zones created."
  value       = [for zone in azurerm_private_dns_zone.this : zone.id]
}

output "private_dns_zones" {
  description = "The created Private DNS Zones."
  value       = azurerm_private_dns_zone.this
}

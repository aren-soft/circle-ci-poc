output "id" {
  description = "The DNS Zone ID."
  value       = azurerm_dns_zone.this.id
}

output "name_servers" {
  description = "A list of values that make up the NS record for the zone."
  value       = azurerm_dns_zone.this.name_servers
}

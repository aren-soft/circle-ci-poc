output "id" {
  description = "The DNS A Record ID."
  value       = azurerm_private_dns_a_record.this.id
}

output "fqdn" {
  description = "The FQDN of the DNS A Record."
  value       = azurerm_private_dns_a_record.this.fqdn
}
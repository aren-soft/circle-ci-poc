output "private_endpoint_private_ip" {
  value       = azurerm_private_endpoint.this.private_service_connection[0].private_ip_address
  description = "The private IP address assigned to the private endpoint."
}

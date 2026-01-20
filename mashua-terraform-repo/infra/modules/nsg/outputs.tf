output "nsg_id" {
  description = "The ID of the Network Security Group"
  value       = azurerm_network_security_group.this.id
}

output "nsg_name" {
  description = "The name of the Network Security Group"
  value       = azurerm_network_security_group.this.name
}

output "nsg_rules" {
  description = "The names of the security rules created in the NSG"
  value       = [for rule in azurerm_network_security_rule.this : rule.name]
}

output "subnet_id" {
  description = "The subnet ID associated with the NSG, if any"
  value       = var.subnet_id
  sensitive   = false
}

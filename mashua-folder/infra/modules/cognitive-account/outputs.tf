output "id" {
  description = "The ID of the Cognitive Account."
  value       = azurerm_cognitive_account.this.id
}

output "name" {
  description = "The name of the Cognitive Account."
  value       = azurerm_cognitive_account.this.name
}

output "endpoint" {
  description = "The endpoint of the Cognitive Account."
  value       = azurerm_cognitive_account.this.endpoint
}

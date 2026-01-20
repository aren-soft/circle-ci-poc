output "subscription_id" {
  description = "The ID of the subscription"
  value       = azurerm_subscription.subscription.id
}

output "subscription_name" {
  description = "The ID of the subscription"
  value       = var.subscription_name
}

output "subscription_subscription_id" {
  description = "The subscription_id value of the created subscription."
  value       = azurerm_subscription.subscription.subscription_id
}

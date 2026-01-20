output "namespace_id" {
  description = "The ID of the Service Bus namespace."
  value       = azurerm_servicebus_namespace.this.id
}

output "namespace_name" {
  description = "The name of the Service Bus namespace."
  value       = azurerm_servicebus_namespace.this.name
}

output "servicebus_queue_ids" {
  description = "Map of Service Bus queue resource IDs, indexed by queue name."
  value = {
    for queue_name, queue_resource in azurerm_servicebus_queue.this :
    queue_name => queue_resource.id
  }
}

output "servicebus_queue_uris" {
  description = "Map of Service Bus queue URIs for sending messages, indexed by queue name."
  value = {
    for queue_name, queue_resource in azurerm_servicebus_queue.this :
    queue_name => "https://${azurerm_servicebus_namespace.this.name}.servicebus.windows.net/${queue_resource.name}"
  }
}

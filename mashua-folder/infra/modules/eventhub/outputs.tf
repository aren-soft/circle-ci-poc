output "eventhub_name" {
  description = "Name of the Event Hub"
  value = azurerm_eventhub.this.name
}

output "event_hub_id" {
  description = "ID of the Event Hub"
  value = azurerm_eventhub.this.id  
}

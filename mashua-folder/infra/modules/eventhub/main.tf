resource "azurerm_eventhub" "this" {
  name              = var.name
  namespace_id      = var.namespace_id
  partition_count   = var.partition_count
  message_retention = var.message_retention
  status            = var.status
}

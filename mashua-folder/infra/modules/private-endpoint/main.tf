resource "azurerm_private_endpoint" "this" {
  name                = var.name
  location            = var.region
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = var.service_connection_name
    private_connection_resource_id = var.resource_id
    is_manual_connection           = var.request_message == null ? false : true
    subresource_names              = var.subresource_names
    request_message                = var.request_message
  }

  private_dns_zone_group {
    name                 = var.dns_zone_group.name
    private_dns_zone_ids = var.dns_zone_group.ids
  }

  tags = var.tags
}

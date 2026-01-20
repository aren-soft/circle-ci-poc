resource "azurerm_cognitive_account" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = var.kind
  sku_name            = var.sku_name

  public_network_access_enabled        = var.public_network_access_enabled
  outbound_network_access_restricted   = var.outbound_network_access_restricted

  tags = var.tags
}

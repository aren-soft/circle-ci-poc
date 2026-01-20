resource "azurerm_virtual_network_peering" "this" {
  name                         = var.name
  resource_group_name          = var.resource_group_name
  virtual_network_name         = var.local_vnet_name
  remote_virtual_network_id    = var.remote_vnet_id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
  allow_gateway_transit        = var.allow_gateway_transit
  use_remote_gateways          = var.use_remote_gateways
  local_subnet_names           = []
  remote_subnet_names          = []
  only_ipv6_peering_enabled    = false
}

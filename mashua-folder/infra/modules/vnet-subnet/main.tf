resource "azurerm_subnet" "this" {
  name                                          = var.name
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = var.virtual_network_name
  address_prefixes                              = flatten([var.address_prefixes])
  service_endpoints                             = flatten(var.service_endpoints)
  private_link_service_network_policies_enabled = var.private_link_service_network_policies_enabled

  dynamic "delegation" {
    for_each = var.delegations
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = flatten([delegation.value.service_delegation.actions])
      }
    }
  }
}

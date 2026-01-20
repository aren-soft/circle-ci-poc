resource "azurerm_virtual_network" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  address_space       = flatten([var.address_space])
  location            = var.location
  tags                = var.tags
}

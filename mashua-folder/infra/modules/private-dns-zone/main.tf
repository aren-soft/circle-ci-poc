resource "azurerm_private_dns_zone" "this" {
  for_each            = var.private_dns_zones
  name                = each.value
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

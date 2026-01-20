module "alb" {
  source              = "../../modules/alb"
  name                = "${local.name_prefix}-alb"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  tags                = local.tags
}

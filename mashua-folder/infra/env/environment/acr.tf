module "acr" {
  source                     = "../../modules/acr"
  name                       = "${local.name_prefix_global}acr"
  sku                        = var.acr.sku
  resource_group_name        = azurerm_resource_group.main.name
  location                   = var.location
  network_rule_bypass_option = "AzureServices"
  public_access_enabled      = true
  tags                       = local.tags
}

module "acr_private_endpoint" {
  source                  = "../../modules/private-endpoint"
  name                    = "${module.acr.name}-pe"
  region                  = var.location
  resource_group_name     = azurerm_resource_group.main.name
  subnet_id               = module.subnet_base.id
  service_connection_name = "${module.acr.name}-pe-conn"
  resource_id             = module.acr.id
  subresource_names       = ["registry"]
  dns_zone_group = {
    name = "acr-dns-zone-group"
    ids  = [var.acr.private_dns_zone_id]
  }
  tags = local.tags
}

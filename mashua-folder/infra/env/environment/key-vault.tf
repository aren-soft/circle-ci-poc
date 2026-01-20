module "key_vault" {
  source                        = "../../modules/key-vault"
  name                          = "${local.name_prefix}-kv"
  resource_group_name           = azurerm_resource_group.main.name
  location                      = var.location
  sku_name                      = var.key_vault.sku
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  enable_rbac_authorization     = true
  soft_delete_retention_days    = 30
  public_network_access_enabled = true
  tags                          = local.tags
}

module "key_vault_private_endpoint" {
  source                  = "../../modules/private-endpoint"
  name                    = "${module.key_vault.name}-pe"
  region                  = var.location
  resource_group_name     = azurerm_resource_group.main.name
  subnet_id               = module.subnet_base.id
  service_connection_name = "${module.key_vault.name}-pe-conn"
  resource_id             = module.key_vault.id
  subresource_names       = ["vault"]
  dns_zone_group = {
    name = "key-vault-dns-zone-group"
    ids  = [var.key_vault.private_dns_zone_id]
  }
  tags = local.tags
}

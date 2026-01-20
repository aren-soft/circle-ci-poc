module "storage_account_main" {
  source                               = "../../modules/storage-account"
  storage_account_name                 = "${local.name_prefix_global}storage"
  resource_group_name                  = azurerm_resource_group.main.name
  location                             = var.location
  account_tier                         = var.storage_account.tier
  account_replication_type             = var.storage_account.replication_type
  public_network_access_enabled        = true
  versioning_enabled                   = true
  blob_soft_delete_number_of_days      = 30
  container_soft_delete_number_of_days = 30
  tags                                 = var.tags
}

module "storage_account_private_endpoint" {
  source                  = "../../modules/private-endpoint"
  name                    = "${module.storage_account_main.name}-pe"
  region                  = var.location
  resource_group_name     = azurerm_resource_group.main.name
  subnet_id               = module.subnet_base.id
  service_connection_name = "${module.storage_account_main.name}-pe-conn"
  resource_id             = module.storage_account_main.id
  subresource_names       = ["blob"]
  dns_zone_group = {
    name = "storage-account-dns-zone-group"
    ids  = [var.storage_account.private_dns_zone_id]
  }
  tags = var.tags
}

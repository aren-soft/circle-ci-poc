resource "azurerm_postgresql_flexible_server" "this" {
  name                              = var.name
  location                          = var.location
  resource_group_name               = var.resource_group_name
  version                           = var.postgres_version
  sku_name                          = var.sku
  public_network_access_enabled     = var.public_access
  create_mode                       = var.create_mode
  delegated_subnet_id               = var.delegated_subnet_id
  private_dns_zone_id               = var.private_dns_zone_id
  administrator_login               = var.administrator_login
  administrator_password_wo         = var.administrator_password
  administrator_password_wo_version = var.administrator_password_version
  backup_retention_days             = var.backup_retention_days
  auto_grow_enabled                 = var.auto_grow_enabled
  storage_mb                        = var.storage_mb
  storage_tier                      = var.storage_tier
  zone                              = var.availability_zone

  authentication {
    active_directory_auth_enabled = var.auth_by_entra_id
    password_auth_enabled         = var.auth_by_password
    tenant_id                     = var.auth_tenant_id
  }

  tags = var.tags
}

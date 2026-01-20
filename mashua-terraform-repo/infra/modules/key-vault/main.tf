resource "azurerm_key_vault" "this" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  enabled_for_disk_encryption   = var.enabled_for_disk_encryption
  tenant_id                     = var.tenant_id
  soft_delete_retention_days    = var.soft_delete_retention_days
  purge_protection_enabled      = var.purge_protection_enabled
  rbac_authorization_enabled    = var.enable_rbac_authorization
  sku_name                      = var.sku_name
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags
}

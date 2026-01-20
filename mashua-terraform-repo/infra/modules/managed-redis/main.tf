resource "azurerm_managed_redis" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku_name                    = var.sku_name
  high_availability_enabled   = var.high_availability_enabled
  public_network_access       = var.public_network_access

  dynamic "default_database" {
    for_each = var.default_database != null ? [var.default_database] : []
    content {
      clustering_policy           = default_database.value.clustering_policy
      geo_replication_group_name  = default_database.value.geo_replication_group_name
    }
  }

  tags = var.tags
}

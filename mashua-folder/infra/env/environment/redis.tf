module "managed_redis" {
  source                    = "../../modules/managed-redis"
  name                      = "${local.name_prefix}-redis"
  resource_group_name       = azurerm_resource_group.main.name
  location                  = var.location
  sku_name                  = "Balanced_B1"
  high_availability_enabled = false
  public_network_access     = "Enabled"

  default_database = {
    clustering_policy = "OSSCluster"
  }

  tags = local.tags

  lifecycle {
    enabled = var.redis.enabled
  }
}

module "managed_redis_private_endpoint" {
  source                  = "../../modules/private-endpoint"
  name                    = "${module.managed_redis.name}-pe"
  region                  = var.location
  resource_group_name     = azurerm_resource_group.main.name
  subnet_id               = module.subnet_db_private.id
  service_connection_name = "${module.managed_redis.name}-pe-conn"
  resource_id             = module.managed_redis.id
  subresource_names       = ["redisEnterprise"]
  dns_zone_group = {
    name = "redis-dns-zone-group"
    ids  = [var.redis.private_dns_zone_id]
  }
  tags = local.tags

  lifecycle {
    enabled = var.redis.enabled
  }
}

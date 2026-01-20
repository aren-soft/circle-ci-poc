module "service_bus" {
  source = "../../modules/service-bus"

  name                = "${local.name_prefix}-sbn"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  sku                 = var.service_bus.sku
  queues              = var.service_bus.queues
  tags                = local.tags
}

module "service_bus_private_endpoint" {
  source                  = "../../modules/private-endpoint"
  name                    = "${module.service_bus.namespace_name}-pe"
  region                  = var.location
  resource_group_name     = azurerm_resource_group.main.name
  subnet_id               = module.subnet_base.id
  service_connection_name = "${module.service_bus.namespace_name}-pe-conn"
  resource_id             = module.service_bus.namespace_id
  subresource_names       = ["namespace"]
  dns_zone_group = {
    name = "servicebus-dns-zone-group"
    ids  = [var.service_bus.private_dns_zone_id]
  }
  tags = local.tags
}

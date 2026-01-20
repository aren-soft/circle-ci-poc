module "event_hub_namespace" {
  source = "../../modules/eventhub-namespace"

  name                          = "${local.name_prefix}-ehn"
  resource_group_name           = azurerm_resource_group.main.name
  location                      = var.location
  sku                           = var.event_hub.sku
  public_network_access_enabled = true
  tags                          = local.tags
}

module "event_hub" {
  source          = "../../modules/eventhub"
  name            = "${local.name_prefix}-eh"
  namespace_id    = module.event_hub_namespace.id
  partition_count = var.event_hub.partition_count
  status          = "Active"
}

module "event_hub_private_endpoint" {
  source                  = "../../modules/private-endpoint"
  name                    = "${module.event_hub_namespace.name}-eh-pe"
  region                  = var.location
  resource_group_name     = azurerm_resource_group.main.name
  subnet_id               = module.subnet_base.id
  service_connection_name = "${module.event_hub_namespace.name}-eh-pe-conn"
  resource_id             = module.event_hub_namespace.id
  subresource_names       = ["namespace"]
  dns_zone_group = {
    name = "eventhub-dns-zone-group"
    ids  = [var.event_hub.private_dns_zone_id]
  }
  tags = local.tags
}

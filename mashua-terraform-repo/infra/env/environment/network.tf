locals {
  private_dns_zones = {
    acr         = "privatelink.azurecr.io"
    aks_cluster = "privatelink.aks.azure.com"
    blob        = "privatelink.blob.core.windows.net"
    key_vault   = "privatelink.vaultcore.azure.net"
    openai      = "privatelink.openai.azure.com"
    postgres    = "privatelink.postgres.database.azure.com"
    redis       = "privatelink.redis.azure.net"
    servicebus  = "privatelink.servicebus.windows.net"
    snowflake   = "privatelink.snowflakecomputing.com"
  }

  db_service_delegation_name = "Microsoft.Databricks/workspaces"
  db_service_delegation_actions = [
    "Microsoft.Network/virtualNetworks/subnets/join/action",
    "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
    "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
  ]

  pg_service_delegation_name = "Microsoft.DBforPostgreSQL/flexibleServers"
  pg_service_delegation_actions = [
    "Microsoft.Network/virtualNetworks/subnets/join/action",
  ]
}

module "virtual_network_spoke" {
  source = "../../modules/vnet"

  name                = "${local.name_prefix}-vnet"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  address_space       = var.address_space.virtual_network
  tags                = var.tags
}

module "subnet_base" {
  source = "../../modules/vnet-subnet"

  name                 = "${local.name_prefix}-app"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = module.virtual_network_spoke.name
  address_prefixes     = var.address_space.subnet_main
}

module "subnet_ingress" {
  source = "../../modules/vnet-subnet"

  name                 = "${local.name_prefix}-app-ingress"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = module.virtual_network_spoke.name
  address_prefixes     = var.address_space.subnet_ingress
}

module "subnet_db_private" {
  source = "../../modules/vnet-subnet"

  name                 = "${local.name_prefix}-data-db-private"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = module.virtual_network_spoke.name
  address_prefixes     = var.address_space.subnet_db_private
  delegations = [
    {
      name = "databricks"
      service_delegation = {
        name    = local.db_service_delegation_name
        actions = local.db_service_delegation_actions
      }
    }
  ]
}

module "subnet_db_public" {
  source = "../../modules/vnet-subnet"

  name                 = "${local.name_prefix}-data-db-public"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = module.virtual_network_spoke.name
  address_prefixes     = var.address_space.subnet_db_public

  delegations = [
    {
      name = "databricks"
      service_delegation = {
        name    = local.db_service_delegation_name
        actions = local.db_service_delegation_actions
      }
    }
  ]
}

module "subnet_postgres" {
  source = "../../modules/vnet-subnet"

  name                 = "${local.name_prefix}-data-postgres"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = module.virtual_network_spoke.name
  address_prefixes     = var.address_space.subnet_postgres
  service_endpoints    = ["Microsoft.Storage"]

  delegations = [{
    name = "postgresql"
    service_delegation = {
      name    = local.pg_service_delegation_name
      actions = local.pg_service_delegation_actions
    }
  }]
}

module "subnet_aks" {
  source = "../../modules/vnet-subnet"

  name                 = "${local.name_prefix}-app-aks"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = module.virtual_network_spoke.name
  address_prefixes     = var.address_space.subnet_aks
}

module "nsg_db_private" {
  source = "../../modules/nsg"

  name                = "${local.name_prefix}-db-nsg"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  subnet_id           = module.subnet_db_private.id
  tags                = var.tags
}

module "nsg_db_public" {
  source = "../../modules/nsg"

  name                = "${local.name_prefix}-db-nsg"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  subnet_id           = module.subnet_db_public.id
  tags                = var.tags
}

module "spoke_to_hub" {
  source              = "../../modules/vnet-peering"
  name                = "to-hub-${var.mgmt_vnet_hub.name}"
  resource_group_name = azurerm_resource_group.main.name
  local_vnet_name     = module.virtual_network_spoke.name
  remote_vnet_id      = var.mgmt_vnet_hub.id
  use_remote_gateways = false
}

module "hub_to_spoke" {
  source                = "../../modules/vnet-peering"
  name                  = "to-spoke-${module.virtual_network_spoke.name}"
  resource_group_name   = var.mgmt_vnet_hub.rg_name
  local_vnet_name       = var.mgmt_vnet_hub.name
  remote_vnet_id        = module.virtual_network_spoke.id
  allow_gateway_transit = true
}

module "private_dns_zone_vnet_link" {
  source                = "../../modules/private-dns-zone-vnet-link"
  for_each              = local.private_dns_zones
  private_dns_zone_name = each.value
  resource_group_name   = var.mgmt_vnet_hub.rg_name
  vnet_id               = module.virtual_network_spoke.id
  vnet_name             = module.virtual_network_spoke.name
}

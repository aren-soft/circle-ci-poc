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
}

resource "azurerm_resource_group" "main" {
  name     = "${local.name_prefix}-rg"
  location = var.location
  tags     = local.tags
}

module "virtual_network_hub" {
  source = "../../modules/vnet"

  name                = "${local.name_prefix}-vnet"
  resource_group_name = resource.azurerm_resource_group.main.name
  location            = var.location
  address_space       = var.address_space.virtual_network
  tags                = local.tags
}

module "subnet_base" {
  source = "../../modules/vnet-subnet"

  name                 = "${local.name_prefix}-app"
  resource_group_name  = resource.azurerm_resource_group.main.name
  virtual_network_name = module.virtual_network_hub.name
  address_prefixes     = var.address_space.subnet_main
}

module "subnet_azure_firewall" {
  source = "../../modules/vnet-subnet"

  name                 = "AzureFirewallSubnet"
  resource_group_name  = resource.azurerm_resource_group.main.name
  virtual_network_name = module.virtual_network_hub.name
  address_prefixes     = var.address_space.subnet_firewall
}

# module "public-dns" {
#   source = "../../modules/public-dns-zone"

#   name                = "azure-knotch.com"
#   resource_group_name = resource.azurerm_resource_group.main.name
#   tags                = local.tags
# }

module "private-dns" {
  source = "../../modules/private-dns-zone"

  private_dns_zones   = local.private_dns_zones
  resource_group_name = resource.azurerm_resource_group.main.name
  tags                = local.tags
}

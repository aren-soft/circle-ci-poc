locals {
  node_pools_availability_zones = null
  max_node_pool_name_length     = 12
}

resource "azurerm_user_assigned_identity" "aks_identity" {
  location            = var.location
  name                = "${local.name_prefix}-aks-identity"
  resource_group_name = azurerm_resource_group.main.name
}

module "aks_cluster" {
  source                    = "../../modules/aks"
  name                      = "${local.name_prefix}-aks-cluster"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.main.name
  dns_prefix                = "${local.name_prefix}-aks-dns"
  sku_tier                  = "Standard"
  identity_ids              = [azurerm_user_assigned_identity.aks_identity.id]
  oidc_issuer_enabled       = true
  workload_identity_enabled = true
  private_cluster_enabled   = false
  local_account_disabled    = true
  azure_rbac_enabled        = true
  aad_rbac_tenant_id        = data.azurerm_client_config.current.tenant_id
  # private_dns_zone_id       = var.aks.private_dns_zone_id
  kubernetes_version = var.aks.kubernetes_version
  tags               = local.tags

  ## Default node pool parameters
  default_node_pool_name = substr("${var.env}default", 0, local.max_node_pool_name_length)
  vm_size                = var.aks.vm_size
  max_pods               = 32
  enable_auto_scaling    = true
  node_count             = 1
  min_count              = 1
  max_count              = 3
  vnet_subnet_id         = module.subnet_aks.id
  availability_zones     = local.node_pools_availability_zones

  ## network profile parameters
  network_plugin          = "azure"
  network_policy          = "azure"
  load_balancer_sku       = "standard"
  outbound_ip_address_ids = []

  depends_on = [
    module.subnet_aks
  ]

  lifecycle {
    enabled = var.aks.enabled
  }
}

module "aks_node_pool_main" {
  source                = "../../modules/aks-node-pool"
  node_pool_name        = substr("worker", 0, local.max_node_pool_name_length)
  kubernetes_cluster_id = module.aks_cluster.id
  vm_size               = var.aks.vm_size
  max_pods              = 32
  enable_auto_scaling   = true
  node_count            = 1
  min_count             = 1
  max_count             = 3
  mode                  = "User"
  vnet_subnet_id        = module.subnet_aks.id
  availability_zones    = local.node_pools_availability_zones
  tags                  = local.tags

  lifecycle {
    enabled = var.aks.enabled
  }
}

resource "azurerm_role_assignment" "k8s_network_permissions" {
  principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id
  role_definition_name = "Network Contributor"
  scope                = azurerm_resource_group.main.id
}

resource "azurerm_role_assignment" "k8s_dns_permissions" {
  principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id
  role_definition_name = "Private DNS Zone Contributor"
  scope                = azurerm_resource_group.main.id
}

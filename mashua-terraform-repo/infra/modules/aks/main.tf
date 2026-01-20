locals {
  default_node_pool_orchestrator_version = var.orchestrator_version != null ? var.orchestrator_version : var.kubernetes_version
  default_node_pool_tags                 = var.node_pool_tags != null ? var.node_pool_tags : var.tags
}

data "azurerm_client_config" "current" {}

resource "azurerm_kubernetes_cluster" "this" {
  name                      = var.name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  dns_prefix                = var.dns_prefix
  sku_tier                  = var.sku_tier
  oidc_issuer_enabled       = var.oidc_issuer_enabled
  workload_identity_enabled = var.workload_identity_enabled
  kubernetes_version        = var.kubernetes_version
  local_account_disabled    = var.local_account_disabled
  private_cluster_enabled   = var.private_cluster_enabled
  private_dns_zone_id       = var.private_dns_zone_id
  tags                      = var.tags

  default_node_pool {
    name                 = var.default_node_pool_name
    vm_size              = var.vm_size
    max_pods             = var.max_pods
    auto_scaling_enabled = var.enable_auto_scaling
    node_count           = var.node_count
    min_count            = var.min_count
    max_count            = var.max_count
    node_labels          = var.node_labels
    vnet_subnet_id       = var.vnet_subnet_id
    orchestrator_version = local.default_node_pool_orchestrator_version
    tags                 = local.default_node_pool_tags
    zones                = var.availability_zones
  }

  identity {
    type         = "UserAssigned"
    identity_ids = flatten([var.identity_ids])
  }

  dynamic "network_profile" {
    for_each = var.network_policy == null ? [] : [var.network_policy]

    content {
      network_plugin      = var.network_plugin
      network_policy      = var.network_policy
      network_plugin_mode = var.network_plugin_mode
      load_balancer_sku   = var.load_balancer_sku

      load_balancer_profile {
        outbound_ip_address_ids = flatten([var.outbound_ip_address_ids])
      }
    }
  }

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.azure_rbac_enabled ? [1] : []

    content {
      azure_rbac_enabled = var.azure_rbac_enabled
      tenant_id          = data.azurerm_client_config.current.tenant_id
    }
  }

  dynamic "oms_agent" {
    for_each = var.oms_agent.log_analytics_workspace_id != null ? [1] : []

    content {
      log_analytics_workspace_id      = var.oms_agent.log_analytics_workspace_id
      msi_auth_for_monitoring_enabled = var.oms_agent.msi_auth_for_monitoring_enabled
    }
  }

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count, // Changes ignored since node count may change based on auto-scaling
    ]
  }
}

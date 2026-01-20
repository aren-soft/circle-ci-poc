locals {
  node_pool_name = var.os_type == "Linux" ? var.node_pool_name : substr(var.node_pool_name, 0, 6)        # See: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool#name
  node_pool_sku  = var.os_sku != null ? var.os_sku : (var.os_type == "Linux" ? "Ubuntu" : "Windows2022") # See: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool#os_sku
}

resource "azurerm_kubernetes_cluster_node_pool" "this" {
  name                  = local.node_pool_name
  kubernetes_cluster_id = var.kubernetes_cluster_id
  vm_size               = var.vm_size
  max_pods              = var.max_pods
  auto_scaling_enabled  = var.enable_auto_scaling
  node_count            = var.node_count
  min_count             = var.min_count
  max_count             = var.max_count
  mode                  = var.mode
  vnet_subnet_id        = var.vnet_subnet_id
  zones                 = var.availability_zones
  orchestrator_version  = var.orchestrator_version
  os_sku                = local.node_pool_sku
  os_type               = var.os_type
  tags                  = var.tags
  node_labels           = var.node_labels

  lifecycle {
    ignore_changes = [
      node_count // Changes ignored since node count may change based on auto-scaling
    ]
  }
}

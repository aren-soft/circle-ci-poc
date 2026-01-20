output "id" {
  description = "The Kubernetes Managed Cluster ID."
  value       = azurerm_kubernetes_cluster.this.id
}

output "name" {
  description = "The Kubernetes Managed Cluster name."
  value       = azurerm_kubernetes_cluster.this.name
}

output "kubelet_identity" {
  description = "A kubelet_identity block. Contains the object_id."
  value       = azurerm_kubernetes_cluster.this.kubelet_identity[0]
}

output "oidc_issuer_url" {
  description = "The OIDC issuer URL that is associated with the cluster."
  value       = azurerm_kubernetes_cluster.this.oidc_issuer_url
}

output "node_resource_group" {
  description = "The auto-generated Resource Group which contains the resources for this Managed Kubernetes Cluster."
  value       = azurerm_kubernetes_cluster.this.node_resource_group
}

output "node_resource_group_id" {
  description = "The ID of the Resource Group containing the resources for this Managed Kubernetes Cluster."
  value       = azurerm_kubernetes_cluster.this.node_resource_group_id
}

output "default_node_pool_subnet_id" {
  description = "The ID of the subnet the default node pool is associated to."
  value       = var.vnet_subnet_id
}

output "id" {
  description = "Databricks workspace resource ID"
  value       = azurerm_databricks_workspace.this.id
}

output "name" {
  description = "Databricks workspace name"
  value       = azurerm_databricks_workspace.this.name
}

output "workspace_url" {
  description = "Databricks workspace URL"
  value       = azurerm_databricks_workspace.this.workspace_url
}

output "managed_resource_group_id" {
  description = "Managed resource group ID created/used by the workspace"
  value       = azurerm_databricks_workspace.this.managed_resource_group_id
}

output "managed_resource_group_name" {
  description = "Managed resource group name used by the workspace"
  value       = azurerm_databricks_workspace.this.managed_resource_group_name
}

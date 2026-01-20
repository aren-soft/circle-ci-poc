locals {
  role_contributor = "Contributor"
}

# resource "azurerm_role_assignment" "container_contributor" {
#   scope                = azurerm_storage_container.container.id
#   role_definition_name = local.role_contributor
#   principal_id         = var.object_id
# }

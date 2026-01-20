locals {
  user_roles_list = flatten([for role, users in var.users_role_assignments : [for user in users : {
    role      = role
    object_id = user
  }]])

  user_roles_map = { for elem in local.user_roles_list : "${elem.role}-${elem.object_id}" => {
    role      = elem.role
    object_id = elem.object_id
  } }
}

resource "azurerm_role_assignment" "users_roles_for_subscription" {
  for_each             = local.user_roles_map
  scope                = "/subscriptions/${module.subscription.subscription_subscription_id}"
  role_definition_name = each.value.role
  principal_id         = each.value.object_id
}

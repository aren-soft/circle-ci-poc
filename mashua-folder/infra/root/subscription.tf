
data "azurerm_billing_mca_account_scope" "billing_mca_account_scope" {
  billing_account_name = var.billing_account_name
  billing_profile_name = var.billing_profile_name
  invoice_section_name = var.invoice_section_name
}

module "subscription" {
  source            = "../../modules/subscription"
  for_each = var.subscription_names
  subscription_name = each.value
  billing_scope_id  = data.azurerm_billing_mca_account_scope.billing_mca_account_scope.id
  workload          = "Production"
}

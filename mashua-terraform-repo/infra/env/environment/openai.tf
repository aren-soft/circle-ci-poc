module "cognitive_account" {
  source                             = "../../modules/cognitive-account"
  name                               = "${local.name_prefix}_openai"
  location                           = var.location
  resource_group_name                = azurerm_resource_group.main.name
  kind                               = "OpenAI"
  sku_name                           = var.cognitive_account.sku_name
  public_network_access_enabled      = true
  outbound_network_access_restricted = false

  tags = var.tags
}

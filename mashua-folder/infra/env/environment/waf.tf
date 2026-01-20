// Created from Azure export template for Terraform
resource "azurerm_web_application_firewall_policy" "waf_policy" {
  location            = var.location
  name                = "${local.name_prefix}-waf-policy"
  resource_group_name = azurerm_resource_group.main.name
  tags                = local.tags

  managed_rules {
    managed_rule_set {
      type    = "Microsoft_DefaultRuleSet"
      version = "2.1"
    }
    managed_rule_set {
      type    = "Microsoft_BotManagerRuleSet"
      version = "1.1"
    }
  }

  policy_settings {
    enabled                                   = false
    file_upload_enforcement                   = true
    file_upload_limit_in_mb                   = 100
    js_challenge_cookie_expiration_in_minutes = 30
    max_request_body_size_in_kb               = 128
    mode                                      = "Detection"
    request_body_check                        = true
    request_body_enforcement                  = true
    request_body_inspect_limit_in_kb          = 128
  }
}

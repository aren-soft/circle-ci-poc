terraform {
  backend "azurerm" {
    resource_group_name  = "rg-aito"
    storage_account_name = "aitotest"
    container_name       = "knotch-state-files"
    key                  = "production/terraform.tfstate"
  }
}

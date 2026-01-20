terraform {
  required_version = ">= 1.11.2"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.57"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

locals {
  valid_access_tier = !contains(["BlobStorage", "FileStorage", "StorageV2"], var.account_kind) ? null : var.access_tier
}

resource "azurerm_storage_account" "this" {
  name                              = var.storage_account_name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  account_kind                      = var.account_kind
  account_tier                      = var.account_tier
  access_tier                       = local.valid_access_tier
  account_replication_type          = var.account_replication_type
  is_hns_enabled                    = var.enable_hns
  sftp_enabled                      = var.enable_sftp
  tags                              = var.tags
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  public_network_access_enabled     = var.public_network_access_enabled
  https_traffic_only_enabled        = var.https_traffic_only_enabled
  shared_access_key_enabled         = var.shared_access_key_enabled

  blob_properties {
    versioning_enabled = var.versioning_enabled
    cors_rule {
      allowed_headers    = var.allowed_headers
      allowed_methods    = var.allowed_methods
      allowed_origins    = var.allowed_origins
      exposed_headers    = var.exposed_headers
      max_age_in_seconds = var.max_age_in_seconds
    }

    dynamic "delete_retention_policy" {
      for_each = (var.blob_soft_delete_number_of_days > 0) ? [1] : []
      content {
        days = var.blob_soft_delete_number_of_days
      }
    }
    dynamic "container_delete_retention_policy" {
      for_each = (var.container_soft_delete_number_of_days > 0) ? [1] : []
      content {
        days = var.container_soft_delete_number_of_days
      }
    }
  }

  lifecycle {
    ignore_changes = [
      customer_managed_key
    ]
  }
}

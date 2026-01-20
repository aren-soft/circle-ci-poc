variable "name" {
  description = "keyvault name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "keyvault location"
  type        = string
}

variable "sku_name" {
  description = "The Name of the SKU to use for this Key Vault."
  type        = string
}

variable "tenant_id" {
  description = "The Tenant ID that should be used for authenticating requests to the Key Vault."
  type        = string
}

variable "soft_delete_retention_days" {
  description = "The number of days that items should be retained after being soft-deleted."
  type        = number
}

variable "enable_rbac_authorization" {
  description = "Indicates whether the Key Vault uses Role Based Access Control (RBAC) for authorization of data actions."
  type        = bool
  default     = true
}

variable "enabled_for_disk_encryption" {
  description = "Indicates whether Azure Disk Encryption is permitted to retrieve secrets from the vault."
  type        = bool
  default     = true
}

variable "purge_protection_enabled" {
  description = "Indicates whethe Purge Protection is enabled for this Key Vault."
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Indicates whether public network access is enabled for the Key Vault. Set to false to enforce private access."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Map of tags to apply to the Key Vault resource"
  type        = map(string)
}

variable "network_acl_default_action" {
  description = "The default action for network ACLs"
  type        = string
  default     = "Deny"
}

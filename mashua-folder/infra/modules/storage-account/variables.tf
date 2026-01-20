variable "resource_group_name" {
  description = "The resource group name."
  type        = string
}

variable "location" {
  description = "The region were the resource will be deployed."
  type        = string
}

variable "storage_account_name" {
  description = "The storage account name."
  type        = string
}

variable "account_kind" {
  description = "The storage account kind. Possible values are: BlobStorage, BlockBlobStorage, FileStorage, Storage, StorageV2. The default value is StorageV2."
  type        = string
  default     = "StorageV2"
  validation {
    condition = (
      var.account_kind != null
      && contains(["BlobStorage", "BlockBlobStorage", "FileStorage", "Storage", "StorageV2"], var.account_kind)
    )
    error_message = "The account kind must be one of the following values: BlobStorage, BlockBlobStorage, FileStorage, Storage, StorageV2."
  }
}

variable "account_tier" {
  description = "The access tier for the storage account. Possible values are Standard, Premium. The default value is Standard."
  type        = string
  default     = "Standard"
  
  validation {
    condition = (
      var.account_tier != null
      && contains(["Standard", "Premium"], var.account_tier)
    )
    error_message = "The account tier must be one of the following values: Standard, Premium."
  }
}

variable "access_tier" {
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts."
  type        = string
  default     = "Hot"
 
  validation {
    condition = (
      var.access_tier != null
      && contains(["Hot", "Cold"], var.access_tier)
    )
    error_message = "The access tier must be one of the following values: Hot, Cold."
  }
}

variable "account_replication_type" {
  description = "The storage account replication type."
  type        = string
  default     = "LRS"

  validation {
    condition = (
      var.account_replication_type != null
      && contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.account_replication_type)
    )
    error_message = "The account replication type must be one of the following values: LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS."
  }
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "allowed_origins" {
  description = "A list of origin domains that will be allowed by CORS."
  type        = list(string)
  default     = ["*"]
}

variable "allowed_headers" {
  description = "A list of headers that are allowed to be a part of the cross-origin request"
  type        = list(string)
  default     = ["*"]
}

variable "allowed_methods" {
  description = "A list of http methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH."
  type        = list(string)
  default     = ["DELETE", "GET", "HEAD", "MERGE", "POST", "OPTIONS", "PUT", "PATCH"]
}

variable "exposed_headers" {
  description = "A list of response headers that are exposed to CORS clients."
  type        = list(string)
  default     = ["*"]
}

variable "max_age_in_seconds" {
  description = "The number of seconds the client should cache a preflight response."
  type        = number
  default     = 200
}

variable "infrastructure_encryption_enabled" {
  description = "Define if infrastructure encryption is enabled."
  type        = bool
  default     = true
}

variable "key_vault_for_encryption_id" {
  description = "The ID of the Key Vault where the Key will be created."
  type        = string
  default     = null
}

variable "enable_storage_encryption" {
  description = "Indicates whether a Customer-managed key should be created in Key Vault for use in enabling encryption on the storage account."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Indicates whether the public network access is enabled."
  type        = bool
  default     = true
}

variable "https_traffic_only_enabled" {
  description = "Indicates whether to deny insecure traffic (HTTP) and allow only secure traffic (HTTPS)"
  type        = bool
  default     = true
}

variable "network_rules" {
  description = "Network rules for the storage account, including default action, allowed subnets, IPs, and bypass services."
  type = object({
    default_action             = string
    virtual_network_subnet_ids = optional(list(string), [])
    ip_rules                   = optional(list(string), [])
    bypass                     = list(string)
  })
  default = null
}

variable "versioning_enabled" {
  description = "Specifies if versioning is enabled in this Azure storage."
  type        = bool
  default     = true
}

variable "blob_soft_delete_number_of_days" {
  description = "The number of days to keep a blob after marked for deletion. To enable blob soft delete the value must be between 1 and 365. To disable it, set it to 0."
  type        = number
  default     = 0
}

variable "container_soft_delete_number_of_days" {
  description = "The number of days to keep a container after marked for deletion. To enable container soft delete the value must be between 1 and 365. To disable it, set it to 0."
  type        = number
  default     = 0
}

variable "enable_identity" {
  description = "Indicates whether to enable managed identity for the Storage."
  type        = bool
  default     = false
}

variable "enable_hns" {
  description = "Indicates whether the Hierarchical Namespaces are enabled for the storage."
  type        = bool
  default     = false
}

variable "enable_sftp" {
  description = "Indicates whether the SFTP is enabled for the storage."
  type        = bool
  default     = false
}

variable "identity_configuration" {
  description = "Configuration for using a User Assigned Managed Identity."
  type = object({
    user_assigned_identity_id           = string
    user_assigned_identity_principal_id = string
  })
  default = {
    user_assigned_identity_id           = null
    user_assigned_identity_principal_id = null
  }
}

variable "shared_access_key_enabled" {
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key"
  type        = bool
  default     = false
}

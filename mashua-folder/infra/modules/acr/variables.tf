variable "name" {
  description = "The Container Registry name."
  type        = string
}

variable "location" {
  description = "The region were the resource will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name."
  type        = string
}

variable "sku" {
  description = "The SKU of the Container Registry. Accepted values are Basic, Standard and Premium."
  type        = string

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "Invalid sku. Possible values are: Basic, Standard and Premium."
  }
}

variable "network_rule_bypass_option" {
  description = "Whether to allow trusted Azure services to access the Container Registry. Possible values are None and AzureServices."
  type        = string

  validation {
    condition     = contains(["None", "AzureServices"], var.network_rule_bypass_option)
    error_message = "Invalid value for network rule bypass option. Possible values are: None and AzureServices."
  }
}

variable "public_access_enabled" {
  description = "Whether to allow public access to the container registry."
  type        = bool
}

variable "tags" {
  description = "Map of tags to apply to the ACR resource"
  type        = map(string)
}

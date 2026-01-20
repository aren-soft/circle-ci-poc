variable "name" {
  type        = string
  description = "The name of the Managed Redis instance"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group name"
}

variable "location" {
  description = "The region were the resource will be deployed."
  type        = string
}

variable "sku_name" {
  type        = string
  description = "Redis SKU"
}

variable "high_availability_enabled" {
  type        = bool
  description = "Enable high availability"
  default     = false
}

variable "public_network_access" {
  type        = string
  description = "Public network access"
  default     = "Enabled"

  validation {
    condition     = contains(["Enabled", "Disabled"], var.public_network_access)
    error_message = "public_network_access must be Enabled or Disabled"
  }
}

variable "default_database" {
  description = "Default database configuration"
  type = object({
    clustering_policy          = string
    geo_replication_group_name = optional(string, null)
  })
  default = null
}

variable "tags" {
  description = "Map of tags to apply to the Application Load Balancer resource"
  type        = map(string)
}


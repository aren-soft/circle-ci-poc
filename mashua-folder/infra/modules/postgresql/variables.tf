variable "name" {
  description = "The name of the PostgreSQL Flexible Server instance"
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the Public IP should exist. Changing this forces a new resource to be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group where this Public IP should exist. Changing this forces a new Public IP to be created."
  type        = string
}

variable "delegated_subnet_id" {
  description = "The ID of the delegated subnet for PostgreSQL Flexible Server"
  type        = string
}

variable "private_dns_zone_id" {
  description = "The ID of the private DNS zone associated with the PostgreSQL Flexible Server"
  type        = string
}

variable "postgres_version" {
  description = "PostgreSQL Flexible Server engine version"
  type        = string
}

variable "sku" {
  description = "SKU of VMs to support the PostgreSQL Flexible Server instance"
  type        = string
}

variable "create_mode" {
  description = "The creation mode which can be used to restore or replicate existing servers. Possible values are Default, GeoRestore, PointInTimeRestore, Replica and Update. Changing this forces a new PostgreSQL Flexible Server to be created."
  type        = string
  default     = "Default"
}

variable "public_access" {
  description = "Specifies whether this PostgreSQL Flexible Server is publicly accessible. Defaults to true"
  type        = bool
  default     = true
}

variable "auth_by_entra_id" {
  description = "Whether or not EntraID authentication is allowed to access the PostgreSQL Flexible Server. Defaults to false"
  type        = bool
  default     = false
}

variable "auth_tenant_id" {
  description = "The Tenant ID of the EntraID Directory which is used by the EntraID authentication. auth_by_entra_id must be set to true"
  type        = string
}

variable "auth_by_password" {
  description = "Whether or not password authentication is allowed to access the PostgreSQL Flexible Server. Defaults to true"
  type        = bool
  default     = true
}

variable "administrator_login" {
  description = "The administrator username for the PostgreSQL Flexible Server"
  type        = string
  default     = null
}

variable "administrator_password" {
  description = "The administrator password for the PostgreSQL Flexible Server"
  type        = string
  sensitive   = true
  default     = null
}

variable "administrator_password_version" {
  description = "The version of the administrator password stored in Key Vault. Defaults to '1'."
  type        = string
  default     = "1"
}

variable "backup_retention_days" {
  description = "(Optional) The backup retention days for the PostgreSQL Flexible Server. Possible values are between 7 and 35 days."
  type        = number
  default     = 7
}

variable "auto_grow_enabled" {
  description = "(Optional) Is the storage auto grow for PostgreSQL Flexible Server enabled? Defaults to false."
  type        = bool
  default     = false
}

variable "storage_mb" {
  description = "Size (in Mb) of storage configured for the Postgres instance."
  type        = string
}

variable "storage_tier" {
  description = "Storage tier for the Postgres storage, must vary according to the storage size."
  type        = string
}

variable "availability_zone" {
  description = "Specifies the Availability Zone in which the PostgreSQL Flexible Server should be located."
  type        = number
  default     = 1
}

variable "standby_availability_zone" {
  description = "Specifies the Availability Zone in which the standby Flexible Server should be located."
  type        = number
  default     = 2
}

variable "tags" {
  description = "Tags for Postgres resource."
  type        = map(string)
  default     = {}
}

variable "private_dns_zone_name" {
  description = "The name of the private DNS zone."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "vnet_id" {
  description = "The ID of the virtual network."
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "tags" {
  description = "Tags for Postgres resource."
  type        = map(string)
  default     = {}
}

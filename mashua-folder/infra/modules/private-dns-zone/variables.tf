
variable "resource_group_name" {
  description = "Specifies the resource group where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "private_dns_zones" {
  description = "Map of private DNS zones to create."
  type        = map(string)
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

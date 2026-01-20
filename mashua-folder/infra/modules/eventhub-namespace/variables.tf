variable "name" {
  description = "The name for the event hub namespace."
  type        = string
}

variable "location" {
  description = "The location where the event hub namespace will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the event hub namespace will be created."
  type        = string
}

variable "sku" {
  description = "The SKU of the event hub namespace."
  type        = string
  default     = "Standard"
}

variable "capacity" {
  description = "The capacity of the event hub namespace."
  type        = number
  default     = 1
}

variable "public_network_access_enabled" {
  description = "Specifies whether public network access is enabled for the Event Hub Namespace."
  type        = bool
  default     = true
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}

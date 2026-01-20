variable "name" {
  description = "The name of the Azure Private Endpoint."
  type        = string
}

variable "region" {
  description = "The Azure region where the Private Endpoint will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group to which the Private Endpoint belongs."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the Private Endpoint will be deployed."
  type        = string
}

variable "service_connection_name" {
  description = "The name of the private service connection."
  type        = string
}

variable "resource_id" {
  description = "The resource ID of the target service for the Private Endpoint connection."
  type        = string
}

variable "subresource_names" {
  description = "A list of subresource names to be used for the private service connection."
  type        = list(string)
}

variable "request_message" {
  description = "Request message for manual private service connections."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to the Azure Private Endpoint."
  type        = map(string)
  default     = {}
}

variable "dns_zone_group" {
  description = "The private DNS zone group to be associated with the private service connection."
  type = object({
    name = string
    ids  = list(string)
  })
}

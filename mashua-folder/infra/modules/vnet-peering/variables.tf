variable "name" {
  description = "The name of the Virtual Network Peering"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the Spoke Virtual Network resides"
  type        = string
}

variable "local_vnet_name" {
  description = "Name of the local Virtual Network"
  type        = string
}

variable "remote_vnet_id" {
  description = "Resource ID of the remote Virtual Network"
  type        = string
}

variable "allow_virtual_network_access" {
  description = "Specifies whether to allow access to the remote virtual network"
  type        = bool
  default     = true
}

variable "allow_forwarded_traffic" {
  description = "Specifies whether to allow forwarded traffic between the peered virtual networks"
  type        = bool
  default     = true
}

variable "allow_gateway_transit" {
  description = "Specifies whether gateway transit is allowed for this peering"
  type        = bool
  default     = false
}

variable "use_remote_gateways" {
  description = "Specifies whether the peered virtual network should use the remote network's gateway"
  type        = bool
  default     = false
}

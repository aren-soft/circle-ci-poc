variable "name" {
  description = "The name of the Network Security Group"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where the NSG will be deployed"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to the resources"
  type        = map(string)
  default     = {}
}

variable "subnet_id" {
  description = "The ID of the subnet to associate with the NSG"
  type        = string
  default     = null
}

variable "security_rules" {
  description = "A list of security rules to apply to the NSG"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = optional(string, "Inbound")
    access                     = optional(string, "Allow")
    protocol                   = optional(string, "Tcp")
    source_port_range          = optional(string, "*")
    source_address_prefix      = optional(string, "VirtualNetwork")
    destination_port_range     = string
    destination_address_prefix = optional(string, "*")
  }))
  default = []
}

variable "create_subnet_association" {
  description = "Flag to indicate if subnet association is needed"
  type        = bool
  default     = true
}

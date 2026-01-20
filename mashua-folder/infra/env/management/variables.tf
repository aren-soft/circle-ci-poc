variable "subscription_id" {
  type        = string
  description = "The Subscription ID to deploy resources into"
  default     = "a7c38d21-c587-4bd0-9913-67218cfdc5bf"
}

variable "location" {
  type        = string
  description = "Name of the Azure region for the resources"
  default     = "eastus"
}

variable "address_space" {
  description = "CIDR address spaces for the environment virtual networks and subnets"
  type = object({
    virtual_network = string
    subnet_main     = string
    subnet_firewall = string
  })
}

variable "tags" {
  type = map(string)
}

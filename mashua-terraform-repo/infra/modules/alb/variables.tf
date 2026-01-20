variable "name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "location" {
  description = "The region were the resource will be deployed."
  type        = string
}

variable "tags" {
  description = "Map of tags to apply to the Application Load Balancer resource"
  type        = map(string)
}

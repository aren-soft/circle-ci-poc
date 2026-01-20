variable "location" {
  description = "The location of the Service Bus resource."
  type        = string
}

variable "name" {
  description = "The name of the Service Bus."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Service Bus."
  type        = string
}

variable "sku" {
  description = "The sku of the Service Bus."
  type        = string
}

variable "queues" {
  description = "List of queues within a service bus."
  type = list(object({
    name                                 = string
    lock_duration                        = optional(string, "PT1M")
    default_message_ttl                  = optional(string, "P1D")
    max_delivery_count                   = optional(number, 10)
    dead_lettering_on_message_expiration = optional(bool, false)
  }))
}

variable "tags" {
  description = "Map of tags to apply to the Service Bus Namespace"
  type        = map(string)
}

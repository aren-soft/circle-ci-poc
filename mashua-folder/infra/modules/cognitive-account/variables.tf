variable "name" {
  description = "The name of the Cognitive Account."
  type        = string
}

variable "location" {
  description = "Azure region where the resource will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group."
  type        = string
}

variable "kind" {
  description = "The kind of Cognitive Account (e.g. OpenAI)."
  type        = string
  validation {
    condition     = length(var.kind) > 0
    error_message = "The 'kind' value must not be empty."
  }
}

variable "sku_name" {
  description = "SKU name of the Cognitive Account."
  type        = string
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled."
  type        = bool
  default     = true
}

variable "outbound_network_access_restricted" {
  description = "Whether outbound network access is restricted."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to apply to the Cognitive Account."
  type        = map(string)
  default     = {}
}

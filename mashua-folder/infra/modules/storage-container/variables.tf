variable "container_name" {
  description = "The name of the Container which should be created within the Storage Account. Changing this forces a new resource to be created."
  type        = string
}

variable "storage_account_id" {
  description = "The name of the Storage Account where the Container should be created. Changing this forces a new resource to be created."
  type        = string
}

variable "container_access_type" {
  description = "The Access Level configured for this Container. Possible values are blob, container or private."
  type        = string
  default     = "private"
  validation {
    condition = (
      var.container_access_type != null
      && contains(["blob", "container", "private"], var.container_access_type)
    )
    error_message = "The container access type must be one of the following values: blob, container, private."
  }
}

variable "container_metadata" {
  description = "A map of key-value pairs representing metadata for storage containers. Keys and values must be strings."
  type        = map(string)
  default     = null
}

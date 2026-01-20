variable "name" {
  description = "The name of the Databricks workspace. Changing this forces a new resource to be created"
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name where the workspace is deployed. Changing this forces a new resource to be created"
  type        = string
}

variable "location" {
  description = "Azure region where the resource has to be created. Changing this forces a new resource to be created"
  type        = string
}

variable "sku" {
  description = "Databricks workspace SKU"
  type        = string

  validation {
    condition     = contains(["standard", "premium", "trial"], var.sku)
    error_message = "sku must be one of: standard, premium, trial."
  }
}

variable "tags" {
  description = "Map of tags to apply to the Key Vault resource"
  type        = map(string)
  default     = {}
}

variable "custom_parameters" {
  description = "Custom parameters for Databricks VNet injection"
  type = object({
    no_public_ip                                         = bool
    virtual_network_id                                   = string
    private_subnet_name                                  = string
    public_subnet_name                                   = string
    private_subnet_network_security_group_association_id = string
    public_subnet_network_security_group_association_id  = string
  })
}

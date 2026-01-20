variable "subscription_id" {
  type        = string
  description = "The Subscription ID to deploy resources into"
  default     = "a7c38d21-c587-4bd0-9913-67218cfdc5bf"
}

variable "env" {
  type        = string
  description = "Environment name (development, staging, production)"

  validation {
    condition     = contains(["development", "staging", "production"], var.env)
    error_message = "Variable env must be one of: development, staging, production"
  }
}

variable "location" {
  type        = string
  description = "Name of the Azure region for the resources"
  default     = "eastus"
}

variable "address_space" {
  description = "CIDR address spaces for the environment virtual networks and subnets"
  type = object({
    virtual_network   = string
    subnet_main       = string
    subnet_ingress    = string
    subnet_aks        = string
    subnet_db_private = string
    subnet_db_public  = string
    subnet_postgres   = string
  })
}

variable "mgmt_vnet_hub" {
  description = "The metadata of the hub virtual network."
  type = object({
    id      = string
    name    = string
    rg_name = string
  })
  default = {
    id      = "/subscriptions/a7c38d21-c587-4bd0-9913-67218cfdc5bf/resourceGroups/kito-mgmt-eu-rg/providers/Microsoft.Network/virtualNetworks/kito-mgmt-eu-vnet"
    name    = "kito-mgmt-eu-vnet"
    rg_name = "kito-mgmt-eu-rg"
  }
}

variable "key_vault" {
  description = "The configuration for the Key Vault instance"
  type = object({
    sku                 = optional(string, "standard")
    private_dns_zone_id = string
  })
}

variable "acr" {
  description = "The configuration for the Azure Container Registry"
  type = object({
    sku                 = optional(string, "standard")
    private_dns_zone_id = string
  })
}

variable "storage_account" {
  description = "The configuration for the Storage Account"
  type = object({
    tier                = optional(string, "Standard")
    replication_type    = optional(string, "LRS")
    private_dns_zone_id = string
  })
}

variable "databricks" {
  description = "The configuration for the Databricks workspace"
  type = object({
    sku     = optional(string, "standard")
    enabled = optional(bool, true)
  })
}

variable "event_hub" {
  description = "The configuration for the Event Hub Namespace"
  type = object({
    sku                 = optional(string, "Standard")
    private_dns_zone_id = string
    partition_count     = optional(number, 1)
  })
}

variable "service_bus" {
  description = "The configuration for the Service Bus Namespace"
  type = object({
    sku                 = optional(string, "Standard")
    private_dns_zone_id = string
    queues = optional(list(object({
      name                                 = string
      lock_duration                        = optional(string, "PT1M")
      default_message_ttl                  = optional(string, "P1D")
      max_delivery_count                   = optional(number, 10)
      dead_lettering_on_message_expiration = optional(bool, false)
    })), [])
  })
}

variable "postgres" {
  description = "The configuration for the PostgreSQL for flexible server"
  type = object({
    sku                    = string
    version                = string
    private_dns_zone_id    = string
    admin                  = optional(string, "psqladmin")
    admin_password_version = optional(string, "1")
    backup_retention_days  = optional(number, 7)
    // Storage MB and tier according to
    // https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server#storage_tier-defaults-based-on-storage_mb
    storage_mb   = optional(string, "524288")
    storage_tier = optional(string, "P20")
    server_configuration = optional(list(object({
      name  = string
      value = string
    })), [])
    databases = list(string)
    enabled   = optional(bool, true)
  })
}

variable "aks" {
  description = "The configuration for the AKS cluster"
  type = object({
    kubernetes_version    = string
    vm_size               = string
    private_dns_zone_id   = optional(string, null)
    agent_count           = optional(number, 3)
    agent_max_count       = optional(number, 5)
    agent_min_count       = optional(number, 3)
    agent_os_disk_size_gb = optional(number, 30)
    agent_vm_size         = optional(string, "Standard_D2s_v3")
    node_pool_name        = optional(string, "agentpool")
    enabled               = optional(bool, true)
  })
}

variable "redis" {
  description = "The configuration for the Managed Redis instance"
  type = object({
    sku_name            = optional(string, "Balanced_B1")
    private_dns_zone_id = string
    enabled             = optional(bool, true)
  })
}

variable "cognitive_account" {
  description = "The configuration for the Cognitive Account"
  type = object({
    sku_name = optional(string, "S0")
  })
}

variable "tags" {
  type = map(string)
}

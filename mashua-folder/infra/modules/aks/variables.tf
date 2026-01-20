variable "name" {
  description = "The name of the Managed Kubernetes Cluster to create. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "The location where the Managed Kubernetes Cluster should be created. Changing this forces a new resource to be created."
  type        = string
}

variable "resource_group_name" {
  description = "Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created."
  type        = string
}

variable "kubernetes_version" {
  description = "Version of Kubernetes specified when creating the AKS managed cluster."
  type        = string
}

variable "local_account_disabled" {
  description = "If true local accounts will be disabled."
  type        = bool
  default     = false
}

variable "dns_prefix" {
  description = "DNS prefix specified when creating the managed cluster. Possible values must begin and end with a letter or number, contain only letters, numbers, and hyphens and be between 1 and 54 characters in length. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "private_cluster_enabled" {
  description = "Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? Changing this forces a new resource to be created."
  default     = false
}

variable "private_dns_zone_id" {
  description = "Either the ID of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None. In case of None you will need to bring your own DNS server and set up resolving, otherwise, the cluster will have issues after provisioning. Changing this forces a new resource to be created."
  default     = null
}

variable "sku_tier" {
  description = "The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free, Paid and Standard (which includes the Uptime SLA)."
  type        = string
  default     = "Standard"
}

variable "authorized_ip_ranges" {
  description = "Set of authorized IP ranges to allow access to API server, e.g. [\"198.51.100.0/24\"]."
  type        = list(string)
  default     = []
}

variable "identity_ids" {
  description = "Specifies a list of User Assigned Managed Identity IDs to be assigned to this Kubernetes Cluster."
  type        = list(string)
}

variable "oidc_issuer_enabled" {
  description = "Enable or Disable the OIDC issuer URL"
  type        = bool
}

variable "workload_identity_enabled" {
  description = "Specifies whether Azure AD Workload Identity should be enabled for the Cluster. Defaults to false."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}

#####################################################################
#################### default_node_pool variables ####################
#####################################################################

variable "default_node_pool_name" {
  description = "The name which should be used for the default Kubernetes Node Pool. Changing this forces a new resource to be created."
  type        = string
  default     = "default"
}

variable "vm_size" {
  description = "The size of the Virtual Machine, such as Standard_D2a_v4."
  type        = string
  default     = "Standard_D2a_v4"
}

variable "max_pods" {
  description = "The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  type        = number
  default     = 32
}

variable "enable_auto_scaling" {
  description = "Should the Kubernetes Auto Scaler be enabled for this Node Pool?"
  type        = bool
  default     = true
}

variable "node_count" {
  description = "The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000 and between min_count and max_count."
  type        = number
  default     = 1
}

variable "min_count" {
  description = "The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000."
  type        = number
  default     = 1
}

variable "max_count" {
  description = "The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000."
  type        = number
  default     = 3
}

variable "vnet_subnet_id" {
  description = "The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "availability_zones" {
  description = "Specifies a list of Availability Zones in which this Kubernetes Cluster should be located. Changing this forces a new Kubernetes Cluster to be created. Like: ['1', '2', '3']"
  type        = list(string)
  default     = null
}

variable "orchestrator_version" {
  description = "Version of Kubernetes used for the Agents. If not specified, the default node pool will be created with the version specified by kubernetes_version."
  type        = string
  default     = null
}

variable "node_pool_tags" {
  description = "A mapping of tags to assign to the Node Pool."
  type        = map(string)
  default     = null
}

variable "node_labels" {
  description = "A map of Kubernetes labels which should be applied to nodes in the Default Node Pool."
  type        = map(string)
  default     = {}
}

###################################################################
#################### network profile variables ####################
###################################################################

variable "network_plugin" {
  description = "Network plugin to use for networking. Currently supported values are azure, kubenet and none. Changing this forces a new resource to be created."
  type        = string
  default     = "azure"
}

variable "network_policy" {
  description = "Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created. NOTE: When network_policy is set to azure, the network_plugin field can only be set to azure."
  type        = string
  default     = "azure"
}

variable "network_plugin_mode" {
  description = "Specifies the network plugin mode used for building the Kubernetes network. Possible value is overlay."
  type        = string
  default     = null
}

variable "load_balancer_sku" {
  description = "Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are basic and standard."
  type        = string
  default     = "standard"
}

variable "outbound_ip_address_ids" {
  description = "The ID of the Public IP Addresses which should be used for outbound communication for the cluster load balancer."
  type        = list(string)
  default     = []
}

##########################################################################################
#################### azure_active_directory_role_based_access_control ####################
##########################################################################################

variable "azure_rbac_enabled" {
  description = "Is Role Based Access Control based on Azure AD enabled?"
  type        = bool
  default     = false
}

variable "aad_rbac_tenant_id" {
  description = "The Tenant ID used for Azure Active Directory Application. If this isn't specified the Tenant ID of the current Subscription is used."
  type        = string
}

####################################################
#################### Monitoring ####################
####################################################

variable "oms_agent" {
  description = <<EOT
    oms_agent = {
      log_analytics_workspace_id: "The ID of the Log Analytics Workspace which the OMS Agent should send data to."
      msi_auth_for_monitoring_enabled: "Is managed identity authentication for monitoring enabled?"
    }
  EOT

  type = object({
    log_analytics_workspace_id      = string
    msi_auth_for_monitoring_enabled = optional(bool)
  })

  default = {
    log_analytics_workspace_id = null
  }
}

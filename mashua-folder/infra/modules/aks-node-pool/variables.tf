variable "node_pool_name" {
  description = "The name of the Node Pool which should be created within the Kubernetes Cluster. Changing this forces a new resource to be created. NOTE: A Windows Node Pool cannot have a name longer than 6 characters."
  type        = string
}

variable "kubernetes_cluster_id" {
  description = "The ID of the Kubernetes Cluster where this Node Pool should exist. Changing this forces a new resource to be created."
  type        = string
}

variable "vm_size" {
  description = "The SKU which should be used for the Virtual Machines used in this Node Pool. Changing this forces a new resource to be created."
  type        = string
  default     = "Standard_D2a_v4"
}

variable "max_pods" {
  description = "The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  type        = number
  default     = 32
}

variable "enable_auto_scaling" {
  description = "Whether to enable auto-scaler."
  type        = bool
  default     = true
}

variable "node_count" {
  description = "The initial number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 (inclusive) for user pools and between 1 and 1000 (inclusive) for system pools and must be a value in the range min_count - max_count."
  type        = number
  default     = 1
}

variable "min_count" {
  description = "The minimum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be less than or equal to max_count."
  type        = number
  default     = 1
}

variable "max_count" {
  description = "The maximum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be greater than or equal to min_count."
  type        = number
  default     = 3
}

variable "mode" {
  description = "Should this Node Pool be used for System or User resources? Possible values are System and User."
  type        = string
  default     = "User"
}

variable "vnet_subnet_id" {
  description = "The ID of the Subnet where this Node Pool should exist. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "availability_zones" {
  description = "Specifies a list of Availability Zones in which this Kubernetes Cluster Node Pool should be located. Changing this forces a new Kubernetes Cluster Node Pool to be created. Like: ['1', '2', '3']"
  type        = list(string)
  default     = null
}

variable "os_sku" {
  description = "Specifies the OS SKU used by the agent pool. Possible values are AzureLinux, Ubuntu, Windows2019 and Windows2022."
  type        = string
  default     = null

  validation {
    condition     = var.os_sku == null ? true : contains(["AzureLinux", "Ubuntu", "Windows2019", "Windows2022"], var.os_sku)
    error_message = "os_sku could be only one of the following values: AzureLinux, Ubuntu, Windows2019, Windows2022."
  }
}

variable "os_type" {
  description = "The Operating System which should be used for this Node Pool. Changing this forces a new resource to be created. Possible values are Linux and Windows. Defaults to Linux."
  type        = string
  default     = "Linux"

  validation {
    condition     = var.os_type != null && contains(["Linux", "Windows"], var.os_type)
    error_message = "os_type could be only one of the following values: Linux, Windows."
  }
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}

variable "node_labels" {
  description = "A map of Kubernetes labels which should be applied to nodes in this Node Pool."
  type        = map(string)
  default     = null
}

variable "orchestrator_version" {
  description = "Kubernetes version for this node pool."
  type        = string
  default     = null
}
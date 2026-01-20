variable "name" {
  description = "The name of the subnet. Changing this forces a new resource to be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the subnet. This must be the resource group that the virtual network resides in. Changing this forces a new resource to be created."
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created."
  type        = string
}

variable "address_prefixes" {
  description = "The address prefixes to use for the subnet."
  type        = string
}

variable "service_endpoints" {
  description = "The list of Service endpoints to associate with the subnet."
  type        = list(string)
  default     = []

  validation {
    condition = alltrue([
      for se in var.service_endpoints : contains([
        "Microsoft.AzureActiveDirectory", "Microsoft.AzureCosmosDB", "Microsoft.ContainerRegistry",
        "Microsoft.EventHub", "Microsoft.KeyVault", "Microsoft.ServiceBus",
        "Microsoft.Sql", "Microsoft.Storage", "Microsoft.Storage.Global", "Microsoft.Web"
      ], se)
    ])
    error_message = "Invalid service endpoints."
  }
}

variable "delegations" {
  description = <<EOT
    List of delegations.
    delegation = {
        name: A name for this delegation.
        service_delegation: {
            name: string. The name of service to delegate to.
            actions: A list of Actions which should be delegated.
        }
    }
  EOT
  type = list(object({
    name = string
    service_delegation = object({
      name    = string
      actions = list(string)
    })
  }))

  default = []

  # service_delegation.name validations
  validation {
    condition = alltrue([
      for del in var.delegations : contains([
        "GitHub.Network/networkSettings", "Informatica.DataManagement/organizations", "Microsoft.ApiManagement/service", "Microsoft.Apollo/npu", "Microsoft.App/environments",
        "Microsoft.App/testClients", "Microsoft.AVS/PrivateClouds", "Microsoft.AzureCosmosDB/clusters", "Microsoft.BareMetal/AzureHostedService", "Microsoft.BareMetal/AzureHPC",
        "Microsoft.BareMetal/AzurePaymentHSM", "Microsoft.BareMetal/AzureVMware", "Microsoft.BareMetal/CrayServers", "Microsoft.BareMetal/MonitoringServers", "Microsoft.Batch/batchAccounts",
        "Microsoft.CloudTest/hostedpools", "Microsoft.CloudTest/images", "Microsoft.CloudTest/pools", "Microsoft.Codespaces/plans", "Microsoft.ContainerInstance/containerGroups",
        "Microsoft.ContainerService/managedClusters", "Microsoft.ContainerService/TestClients", "Microsoft.Databricks/workspaces", "Microsoft.DBforMySQL/flexibleServers", "Microsoft.DBforMySQL/servers",
        "Microsoft.DBforMySQL/serversv2", "Microsoft.DBforPostgreSQL/flexibleServers", "Microsoft.DBforPostgreSQL/serversv2", "Microsoft.DBforPostgreSQL/singleServers", "Microsoft.DelegatedNetwork/controller",
        "Microsoft.DevCenter/networkConnection", "Microsoft.DevOpsInfrastructure/pools", "Microsoft.DocumentDB/cassandraClusters", "Microsoft.Fidalgo/networkSettings", "Microsoft.HardwareSecurityModules/dedicatedHSMs",
        "Microsoft.Kusto/clusters", "Microsoft.LabServices/labplans", "Microsoft.Logic/integrationServiceEnvironments", "Microsoft.MachineLearningServices/workspaces", "Microsoft.Netapp/volumes",
        "Microsoft.Network/dnsResolvers", "Microsoft.Network/managedResolvers", "Microsoft.Network/fpgaNetworkInterfaces", "Microsoft.Network/networkWatchers.", "Microsoft.Network/virtualNetworkGateways",
        "Microsoft.Orbital/orbitalGateways", "Microsoft.PowerPlatform/enterprisePolicies", "Microsoft.PowerPlatform/vnetaccesslinks", "Microsoft.ServiceFabricMesh/networks", "Microsoft.ServiceNetworking/trafficControllers",
        "Microsoft.Singularity/accounts/networks", "Microsoft.Singularity/accounts/npu", "Microsoft.Sql/managedInstances", "Microsoft.Sql/managedInstancesOnebox", "Microsoft.Sql/managedInstancesStage",
        "Microsoft.Sql/managedInstancesTest", "Microsoft.Sql/servers", "Microsoft.StoragePool/diskPools", "Microsoft.StreamAnalytics/streamingJobs", "Microsoft.Synapse/workspaces",
        "Microsoft.Web/hostingEnvironments", "Microsoft.Web/serverFarms", "NGINX.NGINXPLUS/nginxDeployments", "PaloAltoNetworks.Cloudngfw/firewalls", "Qumulo.Storage/fileSystems", "Oracle.Database/networkAttachments"
        ], del.service_delegation.name
      )
    ])
    error_message = "Invalid service delegation name"
  }

  # service_delegation.actions validations
  validation {
    condition = alltrue(flatten([
      for del in var.delegations : [
        for action in del.service_delegation.actions : contains([
          "Microsoft.Network/networkinterfaces/*", "Microsoft.Network/publicIPAddresses/join/action", "Microsoft.Network/publicIPAddresses/read",
          "Microsoft.Network/virtualNetworks/read", "Microsoft.Network/virtualNetworks/subnets/action", "Microsoft.Network/virtualNetworks/subnets/join/action",
          "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
          ], action
        )
      ]
    ]))
    error_message = "Invalid service delegation action"
  }
}

variable "private_link_service_network_policies_enabled" {
  description = "Indicates whether network policies for the private link service on the subnet are enabled."
  type        = string
  default     = true
}

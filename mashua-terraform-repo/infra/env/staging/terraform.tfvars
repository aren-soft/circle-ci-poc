env      = "staging"
location = "eastus2"

address_space = {
  virtual_network   = "10.201.0.0/16"
  subnet_main       = "10.201.0.0/21"
  subnet_ingress    = "10.201.16.0/24"
  subnet_db_private = "10.201.20.0/24"
  subnet_db_public  = "10.201.22.0/24"
  subnet_postgres   = "10.201.24.0/24"
  subnet_aks        = "10.201.64.0/20"
}

// TODO - Add snowflake configuration here
// TODO - Add cognitive account configuration here

key_vault = {
  sku                 = "standard"
  private_dns_zone_id = "/subscriptions/a7c38d21-c587-4bd0-9913-67218cfdc5bf/resourceGroups/kito-mgmt-eu-rg/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"
}

acr = {
  sku                 = "Premium"
  private_dns_zone_id = "/subscriptions/a7c38d21-c587-4bd0-9913-67218cfdc5bf/resourceGroups/kito-mgmt-eu-rg/providers/Microsoft.Network/privateDnsZones/privatelink.azurecr.io"
}

aks = {
  vm_size            = "Standard_D2s_v3"
  kubernetes_version = "1.33"
  enabled            = false
}

databricks = {
  sku     = "standard"
  enabled = false
}

event_hub = {
  private_dns_zone_id = "/subscriptions/a7c38d21-c587-4bd0-9913-67218cfdc5bf/resourceGroups/kito-mgmt-eu-rg/providers/Microsoft.Network/privateDnsZones/privatelink.eventhubs.windows.net"

  sku = "Standard"
}

postgres = {
  private_dns_zone_id = "/subscriptions/a7c38d21-c587-4bd0-9913-67218cfdc5bf/resourceGroups/kito-mgmt-eu-rg/providers/Microsoft.Network/privateDnsZones/privatelink.postgres.database.azure.com"

  sku                    = "GP_Standard_D2s_v3"
  version                = "18"
  admin                  = "psqladmin"
  admin_password_version = "1"
  backup_retention_days  = 7
  storage_mb             = "524288"
  storage_tier           = "P20"

  # postgres_server_configuration = [{
  #   name  = "azure.extensions"
  #   value = "PG_TRGM"
  # }]

  databases = ["athena", "midgar"]

  enabled = false
}

redis = {
  sku_name = "Balanced_B1"
  enabled  = true

  default_database = {
    clustering_policy = "OSSCluster"
  }
}

service_bus = {
  private_dns_zone_id = "/subscriptions/a7c38d21-c587-4bd0-9913-67218cfdc5bf/resourceGroups/kito-mgmt-eu-rg/providers/Microsoft.Network/privateDnsZones/privatelink.servicebus.windows.net"

  sku = "Standard"
  queues = [
    {
      name = "main-queue"
    },
    {
      name = "dead-letter-queue"
    }
  ]
}

tags = {
  env    = "Staging"
  region = "East US 2"
  owner  = "Platform team"
}

resource "azurerm_databricks_workspace" "this" {
  name                        = var.name
  resource_group_name         = var.resource_group_name
  managed_resource_group_name = "${var.name}-rg"
  location                    = var.location
  sku                         = var.sku

  custom_parameters {
    no_public_ip = var.custom_parameters.no_public_ip

    virtual_network_id  = var.custom_parameters.virtual_network_id
    private_subnet_name = var.custom_parameters.private_subnet_name
    public_subnet_name  = var.custom_parameters.public_subnet_name

    private_subnet_network_security_group_association_id = var.custom_parameters.private_subnet_network_security_group_association_id
    public_subnet_network_security_group_association_id  = var.custom_parameters.public_subnet_network_security_group_association_id
  }

  tags = var.tags
}

module "databricks_workspace" {
  source = "../../modules/databricks-workspace"

  name                = "${local.name_prefix}-db-workspace"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  sku                 = var.databricks.sku
  tags                = var.tags

  custom_parameters = {
    no_public_ip                                         = true
    virtual_network_id                                   = module.virtual_network_spoke.id
    private_subnet_name                                  = module.subnet_db_private.name
    public_subnet_name                                   = module.subnet_db_public.name
    private_subnet_network_security_group_association_id = module.subnet_db_private.id
    public_subnet_network_security_group_association_id  = module.subnet_db_public.id
  }

  lifecycle {
    enabled = var.databricks.enabled
  }
}

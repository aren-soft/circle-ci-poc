resource "random_password" "postgresql_admin_password" {
  length           = 32
  lower            = true
  numeric          = true
  upper            = true
  special          = true
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  override_special = "@#!"

  keepers = {
    key = var.postgres.admin_password_version
  }
}

module "postgresql_password_secret" {
  source       = "../../modules/key-vault-secret"
  key_vault_id = module.key_vault.id
  secret_name  = "${local.name_prefix}-postgres-pass"
  secret_value = random_password.postgresql_admin_password.result

  depends_on = [random_password.postgresql_admin_password]

  lifecycle {
    enabled = var.postgres.enabled
  }
}

module "postgres" {
  source                         = "../../modules/postgresql"
  location                       = var.location
  resource_group_name            = azurerm_resource_group.main.name
  name                           = "${local.name_prefix}-postgres"
  postgres_version               = var.postgres.version
  sku                            = var.postgres.sku
  auth_tenant_id                 = data.azurerm_client_config.current.tenant_id
  auth_by_entra_id               = true
  auth_by_password               = true
  administrator_login            = var.postgres.admin
  administrator_password         = random_password.postgresql_admin_password.result
  administrator_password_version = var.postgres.admin_password_version
  backup_retention_days          = var.postgres.backup_retention_days
  storage_mb                     = var.postgres.storage_mb
  storage_tier                   = var.postgres.storage_tier
  availability_zone              = "1"
  delegated_subnet_id            = module.subnet_postgres.id
  private_dns_zone_id            = var.postgres.private_dns_zone_id
  public_access                  = false
  tags                           = local.tags

  depends_on = [module.postgresql_password_secret, random_password.postgresql_admin_password]

  lifecycle {
    enabled = var.postgres.enabled
  }
}

module "postgres_database" {
  source    = "../../modules/postgresql-database"
  for_each  = var.postgres.enabled ? toset(var.postgres.databases) : toset([])
  name      = each.value
  server_id = module.postgres.server_id
  charset   = "UTF8"
  collation = "en_US.utf8"

  depends_on = [module.postgres]
}

resource "azurerm_postgresql_flexible_server_configuration" "postgresql_configuration" {
  for_each = { for cfg in var.postgres.server_configuration : cfg.name => cfg }

  name      = each.value.name
  server_id = module.postgres.server_id
  value     = each.value.value
}

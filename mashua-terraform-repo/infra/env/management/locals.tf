locals {
  // TODO Agregar naming
  loc_abbr    = "eu"
  name_prefix = "kito-mgmt-${local.loc_abbr}"

  tags = {
    Environment = "management"
    CreatedBy   = "Infra team"
    CreatedDate = "2026-01-09"
  }
}

module "naming" {
  source       = "../../modules/naming"
  product_area = "k1"
  environment  = var.env
  location     = var.location
  generator = {
    knotch = {
      resource_group         = 1
      virtual_network        = 1
      subnet                 = 6
      storage_account        = 1
      private_endpoint       = 7
      kubernetes_cluster     = 1
      user_assigned_identity = 1
    }
  }
}

locals {
  names = module.naming
}

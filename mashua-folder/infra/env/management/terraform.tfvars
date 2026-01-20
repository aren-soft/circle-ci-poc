location = "eastus"

address_space = {
  virtual_network = "10.200.0.0/16"
  subnet_main     = "10.200.0.0/21"
  subnet_firewall = "10.200.16.0/26"
}

tags = {
  env        = "management"
  owner      = "platform"
  managed_by = "github-deployment"
}

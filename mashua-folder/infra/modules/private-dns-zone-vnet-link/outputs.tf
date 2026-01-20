# output "private_dns_zone_vnet_link" {
#   description = "The Private DNS Zone Virtual Network Link IDs."
#   value = {
#     for key, link in azurerm_private_dns_zone_virtual_network_link.this :
#     key => link.id
#   }
# }

output "shared_services_vnet_object" {
  value = module.networking_shared_services.vnet
}

output "shared_services_nsg_table" {
  value = module.networking_shared_services.nsg_vnet
}

output "shared_services_subnet_table" {
  value = module.networking_shared_services.vnet_subnets
}

output "resource_group_shared_services" {
  value = azurerm_resource_group.rg_network_shared
}

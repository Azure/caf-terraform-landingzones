output "core_network" {
  sensitive = true
  value     = module.core_network
}

output "hub_network_id" {
  value = module.core_network.vnet_obj.id
}

# output "shared_services_nsg_table" {
#   value = module.networking_shared_services.nsg_vnet
# }

# output "shared_services_subnet_table" {
#   value = module.networking_shared_services.vnet_subnets
# }

# output "resource_group_shared_services" {
#   value = module.resource_group
# }

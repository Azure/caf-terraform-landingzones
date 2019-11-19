output "transit_networking_transit_vnet" {
    value       = module.networking_transit_vnet.vnet
}

# output "transit_virtual_network_gateway" {
#     value       = module.vpn_gateway.object
# }

output "transit_networking_transit_public_ip" {
    value       = module.networking_transit_public_ip.ip_address
}

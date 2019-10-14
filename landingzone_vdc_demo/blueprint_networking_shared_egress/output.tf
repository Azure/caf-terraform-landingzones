output "shared_egress_vnet_object" {
  value = module.networking_shared_egress_vnet.vnet_obj
}

output "shared_egress_vnet_subnets" {
  value = module.networking_shared_egress_vnet.vnet_subnets
}

output "shared_egress_public_ip" {
  value = module.networking_shared_public_ip.ip_address
}

output "shared_egress_az_firewall" {
  value = module.networking_shared_egress_azfirewall.az_firewall_config
}

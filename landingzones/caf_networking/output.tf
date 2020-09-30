output azurerm_firewalls {
  value     = module.landingzones_networking.azurerm_firewalls
  sensitive = true
}

output vnets {
  value     = local.vnets
  sensitive = true
}

output tfstates {
  value     = local.tfstates
  sensitive = false
}

output virtual_wans {
  value       = module.landingzones_networking.virtual_wans
  sensitive   = true
  description = "Virtual WAN output"
}

output "private_dns" {
  value     = module.landingzones_networking.private_dns
  sensitive = true
}

output application_gateways {
  value     = module.landingzones_networking.application_gateways
  sensitive = true
}

output application_gateway_applications {
  value     = module.landingzones_networking.application_gateway_applications
  sensitive = true
}

output public_ip_addresses {
  value     = module.landingzones_networking.public_ip_addresses
  sensitive = true
}

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
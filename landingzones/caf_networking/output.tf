output diagnostics {
  value     = module.networking.diagnostics
  sensitive = true
}

output tfstates {
  value     = local.tfstates
  sensitive = true
}

output vnets {
  value     = local.combined.vnets
  sensitive = true
}

output azurerm_firewalls {
  value     = local.combined.azurerm_firewalls
  sensitive = true
}

output virtual_wans {
  value       = local.combined.virtual_wans
  sensitive   = true
  description = "Virtual WAN output"
}

output private_dns {
  value     = local.combined.private_dns
  sensitive = true
}

output application_gateways {
  value     = local.combined.application_gateways
  sensitive = true
}

output application_gateway_applications {
  value     = local.combined.application_gateway_applications
  sensitive = true
}

output public_ip_addresses {
  value     = local.combined.public_ip_addresses
  sensitive = true
}

output managed_identities {
  value     = local.remote.managed_identities
  sensitive = true
}
output azuread_groups {
  value     = local.remote.azuread_groups
  sensitive = true
}
output express_route_circuits {
  value     = module.networking.express_route_circuits
  sensitive = false
}

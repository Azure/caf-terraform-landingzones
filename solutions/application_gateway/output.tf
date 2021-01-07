output diagnostics {
  value     = local.diagnostics
  sensitive = true
}

output tfstates {
  value     = local.tfstates
  sensitive = true
}

output global_settings {
  value     = local.global_settings
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

output private_dns {
  value     = local.combined.private_dns
  sensitive = true
}

output managed_identities {
  value     = local.combined.managed_identities
  sensitive = true
}

output keyvaults {
  value     = map(var.landingzone.key, module.caf.keyvaults)
  sensitive = true
}

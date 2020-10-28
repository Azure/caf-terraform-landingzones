output global_settings {
  value     = local.global_settings
  sensitive = true
}

output diagnostics {
  value     = module.launchpad.diagnostics
  sensitive = true
}

output networking {
  value = map(
    var.landingzone.key,
    map(
      "vnets", module.launchpad.vnets
    )
  )
  sensitive   = true
  description = "[WARNING] deprecated. Use vnets from 0.4"
}

output vnets {
  value     = map(var.landingzone.key, module.launchpad.vnets)
  sensitive = true
}

output tfstates {
  value     = local.tfstates
  sensitive = true
}

output backend_type {
  value     = var.landingzone.backend_type
  sensitive = true
}

output keyvaults {
  value = map(
    var.landingzone.key, module.launchpad.keyvaults
  )
  sensitive = true
}

output managed_identities {
  value = map(
    var.landingzone.key, module.launchpad.managed_identities
  )
  sensitive = true
}

output aad_apps {
  value = map(
    var.landingzone.key, module.launchpad.aad_apps
  )
  sensitive = true
}

output azuread_groups {
  value = map(
    var.landingzone.key, module.launchpad.azuread_groups
  )
  sensitive = true
}
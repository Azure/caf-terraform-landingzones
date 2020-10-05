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
    var.landingzone.current.key,
    map(
      "vnets", module.launchpad.vnets
    )
  )
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


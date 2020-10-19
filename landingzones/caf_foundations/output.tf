output global_settings {
  value     = local.global_settings
  sensitive = true
}

output diagnostics {
  value     = local.diagnostics
  sensitive = true
}

output vnets {
  value     = local.vnets
  sensitive = true
}

output tfstates {
  value     = local.tfstates
  sensitive = true
}

output managed_identities {
  value     = local.combined.managed_identities
  sensitive = false
}

output azuread_groups {
  value     = local.combined.azuread_groups
  sensitive = true
}

output keyvaults {
  value     = local.combined.keyvaults
  sensitive = false
}

output vnets {
  value     = local.remote.vnets
  sensitive = false
}

output global_settings {
  value     = local.global_settings
  sensitive = true
}

output diagnostics {
  value     = local.diagnostics
  sensitive = true
}

output tfstates {
  value     = local.tfstates
  sensitive = true
}
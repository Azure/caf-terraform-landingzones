output global_settings {
  value     = local.global_settings
  sensitive = true
}
output diagnostics {
  value     = module.foundations.diagnostics
  sensitive = true
}
output vnets {
  value     = local.remote.vnets
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
output tfstates {
  value     = local.tfstates
  sensitive = true
}
output keyvaults {
  value = tomap({
    (var.landingzone.key) = try(module.foundations.keyvaults, {})
  })
  sensitive = true
}

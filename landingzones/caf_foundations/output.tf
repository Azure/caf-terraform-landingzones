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

output keyvaults {
  value     = data.terraform_remote_state.launchpad.outputs.keyvaults
  sensitive = true
}

output tfstates {
  value     = local.tfstates
  sensitive = true
}
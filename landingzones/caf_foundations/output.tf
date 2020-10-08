output global_settings {
  value     = local.global_settings
  sensitive = false
}

output diagnostics {
  value     = local.diagnostics
  sensitive = true
}

output networking {
  value     = local.networking
  sensitive = true
}

output tfstates {
  value     = local.tfstates
  sensitive = true
}

output backend_type {
  value     = data.terraform_remote_state.launchpad.outputs.backend_type
  sensitive = true
}
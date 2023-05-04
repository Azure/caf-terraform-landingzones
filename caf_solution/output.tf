output "objects" {
  value = tomap(
    {
      (try(var.landingzone.key, var.landingzone[var.backend_type].key)) = {
        for key, value in module.solution : key => value
        if try(value, {}) != {}
      }
    }
  )
  sensitive = true
}

output "global_settings" {
  value     = local.global_settings
  sensitive = false
}

output "diagnostics" {
  value     = module.solution.diagnostics
  sensitive = true
}

output "tfstates" {
  value     = local.tfstates
  sensitive = true
}

output "launchpad_identities" {
  value     = var.propagate_launchpad_identities ? data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.launchpad_identities : {}
  sensitive = true
}

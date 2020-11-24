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

output managed_identities {
  value     = local.remote.managed_identities
  sensitive = true
}
output azuread_groups {
  value     = local.remote.azuread_groups
  sensitive = true
}
output storage_accounts {
  value     = module.mlops.storage_accounts
  sensitive = true
}
output application_insights {
  value     = module.mlops.application_insights
  sensitive = true
}
output keyvaults {
  value     = module.mlops.keyvaults
  sensitive = true
}
output ml_workspace {
  value     = module.mlops.machine_learning_workspaces
  sensitive = true
}
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

output app_service_environments {
  value     = local.combined.app_service_environments
  sensitive = true
}

output app_service_plans {
  value     = local.combined.app_service_plans
  sensitive = true
}

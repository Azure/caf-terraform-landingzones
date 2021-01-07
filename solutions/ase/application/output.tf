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

output app_service_plans {
  value     = local.combined.app_service_plans
  sensitive = true
}

output app_services {
  value     = local.combined.app_services
  sensitive = true
}

output mssql_servers {
  value     = local.combined.mssql_servers
  sensitive = true
}

output mssql_elastic_pools {
  value     = local.combined.mssql_elastic_pools
  sensitive = true
}

output redis_caches {
  value     = module.caf.redis_caches
  sensitive = true
}

output managed_identities {
  value     = local.combined.managed_identities
  sensitive = true
}

output keyvaults {
  value     = map(var.landingzone.key, module.caf.keyvaults)
  sensitive = true
}

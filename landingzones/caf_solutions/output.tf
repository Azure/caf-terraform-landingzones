#Core outputs
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

# ASE
output app_service_environments {
  value     = local.combined.app_service_environments
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

# DB
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
  value     = tomap({ (var.landingzone.key) = module.caf.keyvaults })
  sensitive = true
}

# App Gateways
output application_gateways {
  value     = local.combined.application_gateways
  sensitive = true
}

output application_gateway_applications {
  value     = local.combined.application_gateway_applications
  sensitive = true
}

# DNS
output private_dns {
  value     = local.combined.private_dns
  sensitive = true
}

# Kubernetes related outputs
output aks_clusters_kubeconfig {
  value = {
    for key, aks_cluster in module.caf.aks_clusters : key => {
      aks_kubeconfig_cmd       = aks_cluster.aks_kubeconfig_cmd
      aks_kubeconfig_admin_cmd = aks_cluster.aks_kubeconfig_admin_cmd
    }
  }
  sensitive = false
}

output aks_clusters {
  value     = tomap({ (var.landingzone.key) = module.caf.aks_clusters })
  sensitive = true
}

output virtual_machines {
  value     = module.caf.virtual_machines
  sensitive = false
}

# Data and AI outputs
output databricks_workspaces {
  value     = tomap({ (var.landingzone.key) = module.caf.databricks_workspaces })
  sensitive = true
}

output machine_learning_workspaces {
  value     = tomap({ (var.landingzone.key) = module.caf.machine_learning_workspaces })
  sensitive = true
}

output synapse_workspaces {
  value     = tomap({ (var.landingzone.key) = module.caf.synapse_workspaces })
  sensitive = true
}




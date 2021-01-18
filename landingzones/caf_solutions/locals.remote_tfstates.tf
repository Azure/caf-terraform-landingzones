locals {
  landingzone = {
    current = {
      storage_account_name = var.tfstate_storage_account_name
      container_name       = var.tfstate_container_name
      resource_group_name  = var.tfstate_resource_group_name
    }
    lower = {
      storage_account_name = var.lower_storage_account_name
      container_name       = var.lower_container_name
      resource_group_name  = var.lower_resource_group_name
    }
  }
}

data "terraform_remote_state" "remote" {
  for_each = try(var.landingzone.tfstates, {})

  backend = var.landingzone.backend_type
  config = {
    storage_account_name = local.landingzone[try(each.value.level, "current")].storage_account_name
    container_name       = local.landingzone[try(each.value.level, "current")].container_name
    resource_group_name  = local.landingzone[try(each.value.level, "current")].resource_group_name
    subscription_id      = var.tfstate_subscription_id
    key                  = each.value.tfstate
  }
}

locals {
  landingzone_tag = {
    "landingzone" = var.landingzone.key
  }

  tags = merge(var.tags, local.landingzone_tag, local.global_settings.tags, { "level" = var.landingzone.level }, { "environment" = local.global_settings.environment }, { "rover_version" = var.rover_version })

  global_settings = data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.global_settings

  # diagnostics = {
  #   diagnostics_definition   = merge(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.diagnostics_definition, var.diagnostics_definition)
  #   diagnostics_destinations = data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.diagnostics_destinations
  #   storage_accounts         = data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.storage_accounts
  #   log_analytics            = data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.log_analytics
  #   event_hub_namespaces     = data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.event_hub_namespaces
  # }

  remote = {
    diagnostics = {
      # Get the diagnostics settings of services to create
      diagnostic_event_hub_namespaces = var.diagnostic_event_hub_namespaces
      diagnostic_log_analytics        = var.diagnostic_log_analytics
      diagnostic_storage_accounts     = var.diagnostic_storage_accounts

      # Combine the diagnostics definitions
      diagnostics_definition = merge(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.diagnostics_definition, var.diagnostics_definition)
      diagnostics_destinations = {
        event_hub_namespaces = merge(
          try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.diagnostics_destinations.event_hub_namespaces, {}),
          try(var.diagnostics_destinations.event_hub_namespaces, {})
        )
        log_analytics = merge(
          try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.diagnostics_destinations.log_analytics, {}),
          try(var.diagnostics_destinations.log_analytics, {})
        )
        storage = merge(
          try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.diagnostics_destinations.storage, {}),
          try(var.diagnostics_destinations.storage, {})
        )
      }
      # Get the remote existing diagnostics objects
      storage_accounts     = data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.storage_accounts
      log_analytics        = data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.log_analytics
      event_hub_namespaces = data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.event_hub_namespaces
    }

    managed_identities = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.managed_identities[key], {}))
    }
    azuread_groups = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.azuread_groups[key], {}))
    }
    vnets = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.vnets[key], {}))
    }
    private_dns = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.private_dns[key], {}))
    }
    public_ip_addresses = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.public_ip_addresses[key], {}))
    }
    app_service_environments = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.app_service_environments[key], {}))
    }
    app_service_plans = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.app_service_plans[key], {}))
    }
    app_services = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.app_services[key], {}))
    }
    mssql_servers = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.mssql_servers[key], {}))
    }
    mssql_elastic_pools = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.mssql_elastic_pools[key], {}))
    }
    application_gateways = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.application_gateways[key], {}))
    }
    application_gateway_applications = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.application_gateway_applications[key], {}))
    }
    keyvaults = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.keyvaults[key], {}))
    }
  }

  combined = {
    vnets                            = merge(local.remote.vnets, map(var.landingzone.key, module.caf.vnets))
    public_ip_addresses              = merge(local.remote.public_ip_addresses, map(var.landingzone.key, module.caf.public_ip_addresses))
    private_dns                      = merge(local.remote.private_dns, map(var.landingzone.key, module.caf.private_dns))
    application_gateways             = merge(local.remote.application_gateways, map(var.landingzone.key, module.caf.application_gateways))
    application_gateway_applications = merge(local.remote.application_gateway_applications, map(var.landingzone.key, module.caf.application_gateway_applications))
    app_service_environments         = merge(local.remote.app_service_environments, map(var.landingzone.key, module.caf.app_service_environments))
    app_service_plans                = merge(local.remote.app_service_plans, map(var.landingzone.key, module.caf.app_service_plans))
    app_services                     = merge(local.remote.app_services, map(var.landingzone.key, module.caf.app_services))
    managed_identities               = merge(local.remote.managed_identities, map(var.landingzone.key, module.caf.managed_identities))
    mssql_servers                    = merge(local.remote.mssql_servers, map(var.landingzone.key, module.caf.mssql_servers))
    mssql_elastic_pools              = merge(local.remote.mssql_elastic_pools, map(var.landingzone.key, module.caf.mssql_elastic_pools))
  }
}

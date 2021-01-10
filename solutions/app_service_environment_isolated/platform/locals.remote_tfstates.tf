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

  diagnostics = {
    diagnostics_definition   = merge(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.diagnostics_definition, var.diagnostics_definition)
    diagnostics_destinations = data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.diagnostics_destinations
    storage_accounts         = data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.storage_accounts
    log_analytics            = data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.log_analytics
    event_hub_namespaces     = data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.event_hub_namespaces
  }

  remote = {
    vnets = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.vnets[key], {}))
    }
    private_dns = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.private_dns[key], {}))
    }
    app_service_environments = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.app_service_environments[key], {}))
    }
    app_service_plans = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.app_service_plans[key], {}))
    }
  }

  combined = {
    app_service_environments         = merge(local.remote.app_service_environments, map(var.landingzone.key, module.caf.app_service_environments))
    app_service_plans                = merge(local.remote.app_service_plans, map(var.landingzone.key, module.caf.app_service_plans))
  }
}

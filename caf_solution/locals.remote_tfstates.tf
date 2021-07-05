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
  config  = local.remote_state[try(each.value.backend_type, var.landingzone.backend_type, "azurerm")][each.key]
}

locals {

  remote_state = {
    azurerm = {
      for key, value in try(var.landingzone.tfstates, {}) : key => {
        container_name       = try(value.workspace, local.landingzone[try(value.level, "current")].container_name)
        key                  = value.tfstate
        resource_group_name  = try(value.resource_group_name, local.landingzone[try(value.level, "current")].resource_group_name)
        storage_account_name = try(value.storage_account_name, local.landingzone[try(value.level, "current")].storage_account_name)
        subscription_id      = try(value.subscription_id, var.tfstate_subscription_id)
        tenant_id            = try(value.tenant_id, data.azurerm_client_config.current.tenant_id)
        sas_token            = try(value.sas_token, null) != null ? var.sas_token : null
      }
    }

  }

  tags = merge(try(local.global_settings.tags, {}), { "level" = var.landingzone.level }, try({ "environment" = local.global_settings.environment }, {}), { "rover_version" = var.rover_version }, var.tags)

  global_settings = merge(
    try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.objects[var.landingzone.global_settings_key].global_settings, null),
    try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.global_settings, null),
    var.global_settings
  )

  diagnostics = {
    # Get the diagnostics settings of services to create
    diagnostic_event_hub_namespaces = var.diagnostic_event_hub_namespaces
    diagnostic_log_analytics        = var.diagnostic_log_analytics
    diagnostic_storage_accounts     = var.diagnostic_storage_accounts

    # Combine the diagnostics definitions
    diagnostics_definition = merge(
      try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.diagnostics_definition, null),
      try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.objects[var.landingzone.global_settings_key].diagnostics.diagnostics_definition, null),
      var.diagnostics_definition
    )
    diagnostics_destinations = {
      event_hub_namespaces = merge(
        try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.diagnostics_destinations.event_hub_namespaces, {}),
        try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.objects[var.landingzone.global_settings_key].diagnostics.diagnostics_destinations.event_hub_namespaces, null),
        try(var.diagnostics_destinations.event_hub_namespaces, {})
      )
      log_analytics = merge(
        try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.diagnostics_destinations.log_analytics, {}),
        try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.objects[var.landingzone.global_settings_key].diagnostics.diagnostics_destinations.log_analytics, null),
        try(var.diagnostics_destinations.log_analytics, {})
      )
      storage = merge(
        try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.diagnostics_destinations.storage, {}),
        try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.objects[var.landingzone.global_settings_key].diagnostics.diagnostics_destinations.storage, null),
        try(var.diagnostics_destinations.storage, {})
      )
    }
    # Get the remote existing diagnostics objects
    storage_accounts = merge(
      try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.storage_accounts, null),
      try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.objects[var.landingzone.global_settings_key].diagnostics.storage_accounts, null)
    )

    log_analytics = merge(
      try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.log_analytics, null),
      try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.objects[var.landingzone.global_settings_key].diagnostics.log_analytics, null)
    )
    event_hub_namespaces = merge(
      try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.event_hub_namespaces, null),
      try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.objects[var.landingzone.global_settings_key].diagnostics.event_hub_namespaces, null)
    )
  }

}

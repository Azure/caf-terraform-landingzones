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
    container_name       = try(each.value.workspace, local.landingzone[try(each.value.level, "current")].container_name)
    resource_group_name  = local.landingzone[try(each.value.level, "current")].resource_group_name
    subscription_id      = var.tfstate_subscription_id
    key                  = each.value.tfstate
  }
}

locals {
  landingzone_tag = {
    "landingzone" = var.landingzone.key
  }

  tags            = merge(try(local.global_settings.tags, {}), local.landingzone_tag, { "level" = var.landingzone.level }, try({ "environment" = local.global_settings.environment }, {}), { "rover_version" = var.rover_version }, var.tags)
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
    storage_accounts     = coalesce(
      try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.storage_accounts, null),
      try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.objects[var.landingzone.global_settings_key].diagnostics.storage_accounts, null)
    )

    log_analytics        = coalesce(
      try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.log_analytics, null),
      try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.objects[var.landingzone.global_settings_key].diagnostics.log_analytics, null)
    )
    event_hub_namespaces = coalesce(
      try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics.event_hub_namespaces, null),
      try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.objects[var.landingzone.global_settings_key].diagnostics.event_hub_namespaces, null)
    )
  }

}

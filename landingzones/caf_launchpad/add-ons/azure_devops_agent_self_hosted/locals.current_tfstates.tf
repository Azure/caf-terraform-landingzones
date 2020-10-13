data "terraform_remote_state" "launchpad" {

  backend = var.landingzone.backend_type
  config = {
    storage_account_name = var.tfstate_storage_account_name
    container_name       = var.tfstate_container_name
    resource_group_name  = var.tfstate_resource_group_name
    key                  = var.landingzone.current.launchpad.tfstate
  }
}

locals {
  landingzone_tag = {
    "landingzone" = var.landingzone.current.key
  }

  tags = merge(var.tags, local.landingzone_tag, { "level" = var.landingzone.current.level }, { "environment" = local.global_settings.environment }, { "rover_version" = var.rover_version })

  global_settings = {
    prefix             = data.terraform_remote_state.launchpad.outputs.global_settings.prefix
    prefix_with_hyphen = data.terraform_remote_state.launchpad.outputs.global_settings.prefix_with_hyphen
    default_region     = try(var.global_settings.default_region, data.terraform_remote_state.launchpad.outputs.global_settings.default_region)
    environment        = data.terraform_remote_state.launchpad.outputs.global_settings.environment
    regions            = try(var.global_settings.regions, data.terraform_remote_state.launchpad.outputs.global_settings.regions)
  }

  diagnostics = {
    diagnostics_definition   = merge(data.terraform_remote_state.launchpad.outputs.diagnostics.diagnostics_definition, var.diagnostics_definition)
    diagnostics_destinations = data.terraform_remote_state.launchpad.outputs.diagnostics.diagnostics_destinations
    storage_accounts         = data.terraform_remote_state.launchpad.outputs.diagnostics.storage_accounts
    log_analytics            = data.terraform_remote_state.launchpad.outputs.diagnostics.log_analytics
  }


  aad_apps = merge(
    data.terraform_remote_state.launchpad.outputs.aad_apps,
    module.caf.aad_apps
  )

  keyvaults = merge(
    data.terraform_remote_state.launchpad.outputs.keyvaults,
    module.caf.keyvaults
  )

  outputs = data.terraform_remote_state.launchpad.outputs

  # Merge all remote networking objects
  current_networking         = data.terraform_remote_state.launchpad.outputs.networking
  current_keyvaults          = data.terraform_remote_state.launchpad.outputs.keyvaults
  current_managed_identities = data.terraform_remote_state.launchpad.outputs.managed_identities

  networking = merge(
    local.current_networking,
    map(
      var.landingzone.current.key,
      map(
        "vnets", try(module.caf.vnets, {})
      )
    )
  )

}

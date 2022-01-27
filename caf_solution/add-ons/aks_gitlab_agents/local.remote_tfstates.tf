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

  global_settings = merge(
    try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.objects[var.landingzone.global_settings_key].global_settings, null),
    try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.global_settings, null)
  )

  diagnostics = merge(
    try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.objects[var.landingzone.global_settings_key].diagnostics, null),
    try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics, null)
  )

  remote = {
    tags            = merge(local.global_settings.tags, local.landingzone_tag, { "level" = var.landingzone.level }, { "environment" = local.global_settings.environment }, { "rover_version" = var.rover_version }, var.tags)
    global_settings = local.global_settings
    diagnostics     = local.diagnostics


    aks_clusters = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].aks_clusters, {}))
    }


    managed_identities = data.terraform_remote_state.remote[var.aad-pod-identity.lz_key].outputs[var.aad-pod-identity.output_key]
  }

}

output "managed_identities" {
  value = local.remote.managed_identities
}
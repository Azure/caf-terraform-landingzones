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

  backend = try(each.value.backend_type, "azurerm")
  config  = local.remote_state[try(each.value.backend_type, "azurerm")][each.key]
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
      }
    }
    remote = {
      for key, value in try(var.landingzone.tfstates, {}) : key => {
        hostname     = try(value.hostname, var.tf_cloud_hostname)
        organization = try(value.organization, var.tf_cloud_organization)
        workspaces = {
          name = value.workspace
        }
      } if try(value.backend_type, "azurerm") == "remote"
    }
  }

  landingzone_tag = {
    "landingzone" = var.landingzone.key
  }

  global_settings = merge(
    try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.global_settings, null),
    try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.objects[var.landingzone.global_settings_key].global_settings, null)
  )

  caf = {

    global_settings = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(
        try(data.terraform_remote_state.remote[key].outputs.global_settings, {}),
        try(data.terraform_remote_state.remote[key].outputs.objects[key].global_settings, {})
      )
    }
    diagnostics = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(
        try(data.terraform_remote_state.remote[key].outputs.diagnostics, {}),
        try(data.terraform_remote_state.remote[key].outputs.objects[key].diagnostics, {})
      )
    }
    managed_identities = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].managed_identities, {}))
    }
    azuread_groups = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].azuread_groups, {}))
    }
    azuread_service_principals = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].azuread_service_principals, {}))
    }
    azuread_applications = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].azuread_applications, {}))
    }
    subscriptions = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].subscriptions, {}))
    }
    objects = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key], {}))
    }
  }

}

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
        sas_token            = try(value.sas_token, null) != null ? var.sas_token : null
        use_azuread_auth     = try(value.use_azuread_auth, true)
      } if try(value.backend_type, "azurerm") == "azurerm"
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

  tags = merge(local.global_settings.tags, local.landingzone_tag, { "level" = var.landingzone.level }, { "environment" = local.global_settings.environment }, { "rover_version" = var.rover_version }, var.tags)

  global_settings = data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.objects[var.landingzone.global_settings_key].global_settings
  diagnostics     = data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.objects[var.landingzone.global_settings_key].diagnostics

  combined = {
    aad_apps           = merge(local.remote.aad_apps, tomap({ (var.landingzone.key) = module.caf.aad_apps }))
    azuread_groups     = merge(local.remote.azuread_groups, tomap({ (var.landingzone.key) = module.caf.azuread_groups }))
    keyvaults          = merge(local.remote.keyvaults, tomap({ (var.landingzone.key) = module.caf.keyvaults }))
    managed_identities = merge(local.remote.managed_identities, tomap({ (var.landingzone.key) = module.caf.managed_identities }))
  }

  remote = {
    aad_apps = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].aad_apps, {}))
    }

    azuread_groups = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].azuread_groups, {}))
    }

    keyvaults = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].keyvaults, {}))
    }

    managed_identities = merge(
      tomap({ "launchpad" = try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.launchpad_identities["launchpad"].managed_identities, {}) }),
      {
        for key, value in try(var.landingzone.tfstates, {}) : key => merge(
          try(data.terraform_remote_state.remote[key].outputs.objects[key].managed_identities, {})
        )
      }
    )
  }


}

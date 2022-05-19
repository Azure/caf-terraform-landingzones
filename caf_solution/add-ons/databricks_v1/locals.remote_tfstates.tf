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
        subscription_id      = try(value.subscription_id, data.azurerm_client_config.current.subscription_id)
        tenant_id            = try(value.tenant_id, data.azurerm_client_config.current.tenant_id)
      }
    }
  }

  global_settings = data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.objects[var.landingzone.global_settings_key].global_settings

  remote = {
    databricks_workspaces = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].databricks_workspaces, {}))
    }
  }

}

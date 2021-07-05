locals {
  landingzone = {
    current = {
      storage_account_name = var.tfstate_storage_account_name
      container_name       = var.tfstate_container_name
      resource_group_name  = var.tfstate_resource_group_name
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
        container_name       = value.workspace
        key                  = value.tfstate
        resource_group_name  = value.resource_group_name
        storage_account_name = value.storage_account_name
        subscription_id      = value.subscription_id
        tenant_id            = value.tenant_id
        sas_token            = try(value.sas_token, null) != null ? var.sas_token : null
      }
    }

  }

}
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
    container_name       = try(each.value.workspace, local.landingzone[try(each.value.level, "current")].container_name)
    key                  = each.value.tfstate
    resource_group_name  = try(each.value.resource_group_name, local.landingzone[try(each.value.level, "current")].resource_group_name)
    sas_token            = try(each.value.sas_token, null) != null ? var.sas_token : null
    storage_account_name = try(each.value.storage_account_name, local.landingzone[try(each.value.level, "current")].storage_account_name)
    subscription_id      = try(each.value.subscription_id, data.azurerm_client_config.current.subscription_id)
    tenant_id            = try(each.value.tenant_id, data.azurerm_client_config.current.tenant_id)
    use_azuread_auth     = try(each.value.use_azuread_auth, true)
  }
}

data "azurerm_client_config" "current" {
  provider = azurerm.vnet
}

provider "azurerm" {
  alias = "virtual_hub"
  features {}
  skip_provider_registration = true
  subscription_id            = var.virtual_hub_subscription_id
  tenant_id                  = var.virtual_hub_tenant_id

  # Source tenants for virtual networks.
  # Client ID must have permissions on those virtual_networks
  auxiliary_tenant_ids = try(var.landingzone.tfstates[var.virtual_hub_lz_key].auxiliary_tenant_ids, null)
}
provider "azurerm" {
  features {}
  alias                      = "vnet"
  skip_provider_registration = true
  subscription_id            = var.virtual_network_subscription_id
  tenant_id                  = var.virtual_network_tenant_id
}


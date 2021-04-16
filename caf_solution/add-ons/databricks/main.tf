terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.43"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "1.0.0"
    }
    databricks = {
      source  = "databrickslabs/databricks"
      version = "~> 0.2.5"
    }
  }
  required_version = ">= 0.13"
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

data "azurerm_client_config" "current" {}

data "terraform_remote_state" "landingzone" {
  backend = "azurerm"
  config = {
    storage_account_name = var.tfstate_storage_account_name
    container_name       = var.tfstate_container_name
    key                  = var.tfstate_key
    resource_group_name  = var.tfstate_resource_group_name
  }
}

locals {
  diagnostics = {
    diagnostics_definition   = merge(data.terraform_remote_state.landingzone.outputs.diagnostics.diagnostics_definition, var.diagnostics_definition)
    diagnostics_destinations = data.terraform_remote_state.landingzone.outputs.diagnostics.diagnostics_destinations
    storage_accounts         = data.terraform_remote_state.landingzone.outputs.diagnostics.storage_accounts
    log_analytics            = data.terraform_remote_state.landingzone.outputs.diagnostics.log_analytics
  }



  # Update the tfstates map
  tfstates = merge(
    tomap(
      {
        (var.landingzone.key) = local.backend[var.landingzone.backend_type]
      }
    )
    ,
    data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.tfstates
  )


  backend = {
    azurerm = {
      storage_account_name = var.tfstate_storage_account_name
      container_name       = var.tfstate_container_name
      resource_group_name  = var.tfstate_resource_group_name
      key                  = var.tfstate_key
      level                = var.landingzone.level
      tenant_id            = var.tenant_id
      subscription_id      = data.azurerm_client_config.current.subscription_id
    }
  }

}

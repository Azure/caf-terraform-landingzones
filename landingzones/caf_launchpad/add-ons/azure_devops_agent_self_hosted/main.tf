terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.28.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 1.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 2.2.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 2.1.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 1.2.0"
    }
    azuredevops = {
      source  = "terraform-providers/azuredevops"
      version = "~> 0.0.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 2.2.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~>1.1.0"
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

data "terraform_remote_state" "launchpad" {
  backend = "azurerm"
  config = {
    storage_account_name = var.lowerlevel_storage_account_name
    container_name       = var.lowerlevel_container_name
    key                  = var.lowerlevel_key
    resource_group_name  = var.lowerlevel_resource_group_name
  }
}

locals {
  tags = merge(var.tags, { "level" = var.level }, { "environment" = var.environment }, { "rover_version" = var.rover_version })

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

  keyvaults = merge(
    data.terraform_remote_state.launchpad.outputs.keyvaults,
    module.caf.keyvaults
  )
  aad_apps = merge(
    data.terraform_remote_state.launchpad.outputs.aad_apps,
    module.caf.aad_apps
  )
  outputs = data.terraform_remote_state.launchpad.outputs

  tfstates = merge(
    map(var.landingzone_name,
      map(
        "storage_account_name", var.tfstate_storage_account_name,
        "container_name", var.tfstate_container_name,
        "resource_group_name", var.tfstate_resource_group_name,
        "key", var.tfstate_key,
        "level", var.level,
        "tenant_id", data.azurerm_client_config.current.tenant_id,
        "subscription_id", data.azurerm_client_config.current.subscription_id
      )
    )
    ,
    data.terraform_remote_state.launchpad.outputs.tfstates
  )

}

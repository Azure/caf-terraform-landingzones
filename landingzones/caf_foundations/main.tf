terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.30.0"
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
    tls = {
      source  = "hashicorp/tls"
      version = "~> 2.2.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.1.0"
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
data "azurerm_subscription" "current" {}

data "terraform_remote_state" "launchpad" {
  backend = var.landingzone.backend_type
  config = {
    storage_account_name = var.lower_storage_account_name
    container_name       = var.lower_container_name
    key                  = var.landingzone.lower.launchpad.tfstate
    resource_group_name  = var.lower_resource_group_name
  }
}

locals {
  landingzone_tag = {
    landingzone = basename(abspath(path.module))
  }
  tags = merge(local.landingzone_tag, { "level" = var.landingzone.current.level }, { "environment" = local.global_settings.environment }, { "rover_version" = var.rover_version }, var.tags)

  # Passing through the higher level the base diagnostics settings
  global_settings = data.terraform_remote_state.launchpad.outputs.global_settings
  diagnostics     = data.terraform_remote_state.launchpad.outputs.diagnostics

  networking = merge(
    map(var.landingzone.current.key, {}),
    data.terraform_remote_state.launchpad.outputs.networking
  )

  # Update the tfstates map
  tfstates = merge(
    map(var.landingzone.current.key,
      map(
        data.terraform_remote_state.launchpad.outputs.backend_type,
        local.backend[data.terraform_remote_state.launchpad.outputs.backend_type]
      )
    )
    ,
    data.terraform_remote_state.launchpad.outputs.tfstates
  )

  backend = {
    azurerm = {
      storage_account_name = var.tfstate_storage_account_name
      container_name       = var.tfstate_container_name
      resource_group_name  = var.tfstate_resource_group_name
      key                  = var.tfstate_key
      level                = var.landingzone.current.level
      tenant_id            = data.azurerm_client_config.current.tenant_id
      subscription_id      = data.azurerm_client_config.current.subscription_id
    }
  }

}


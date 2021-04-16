terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.40"
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
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.22.0"
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

locals {

  # Update the tfstates map
  tfstates = merge(
    tomap(
      {
        (var.landingzone.key) = local.backend["tfc"]
      }
    )
    ,
    data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.tfstates
  )


  backend = {
    tfc = {
      level           = var.landingzone.level,
      tenant_id       = data.azurerm_client_config.current.tenant_id,
      subscription_id = data.azurerm_client_config.current.subscription_id
    }
  }
}
terraform {
  required_providers {
    // azurerm version driven by the caf module
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 1.4.0"
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
      source  = "microsoft/azuredevops"
      version = "~> 0.1.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 2.2.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2.0"
    }
  }
  required_version = ">= 0.13"
}

provider "azurerm" {
  partner_id = "ca4078f8-9bc4-471b-ab5b-3af6b86a42c8"
  # partner identifier for CAF Terraform landing zones.
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

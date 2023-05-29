terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.56.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.36.0"
    }
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "~> 0.5.0"
    }
  }
  required_version = ">= 1.3.0"
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
    can(var.landingzone.global_settings_key) ? data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.tfstates : {}
  )


  backend = {
    azurerm = {
      storage_account_name = var.tfstate_storage_account_name
      container_name       = var.tfstate_container_name
      resource_group_name  = var.tfstate_resource_group_name
      key                  = var.tfstate_key
      level                = try(var.landingzone.level, var.landingzone[var.backend_type].level)
      tenant_id            = var.tenant_id
      subscription_id      = data.azurerm_client_config.current.subscription_id
    }
    remote = {
      hostname     = var.tf_cloud_hostname
      organization = var.tf_cloud_organization
      workspaces = {
        name = var.workspace
      }
    }
  }

}

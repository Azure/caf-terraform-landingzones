terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.99.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      # version = "~> 1.0.0"
      version = "~> 1.4.0"
    }
    random = {
      source  = "hashicorp/random"
      # version = "~> 2.2.1"
      version = "~> 3.3.0"
    }
    null = {
      source  = "hashicorp/null"
      # version = "~> 2.1.0"
      version = "~> 3.1.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.1.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.2.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.32.1"
      # version = "~> 0.35.0"
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

provider "azurerm" {
  alias                      = "vhub"
  skip_provider_registration = true
  features {}
  subscription_id = local.connectivity_subscription_id
  tenant_id       = local.connectivity_tenant_id
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
  )


  backend = {
    tfc = {
      level           = var.landingzone.level,
      tenant_id       = data.azurerm_client_config.current.tenant_id,
      subscription_id = data.azurerm_client_config.current.subscription_id
    }
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
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.32.0"
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
  tfstates = merge(
    map(var.landingzone.backend_type,
      map(
        "level", var.landingzone.level,
        "tenant_id", data.azurerm_client_config.current.tenant_id,
        "subscription_id", data.azurerm_client_config.current.subscription_id
      )
    )
  )
}
provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
  }
}

terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.25.0"
    }
  }
  required_version = ">= 0.13"
}

locals {
  landingzone_tag = {
    "landingzone" = basename(abspath(path.module))
  }
  tags = merge(var.tags, local.landingzone_tag)
}

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
  global_settings     = data.terraform_remote_state.launchpad.outputs.global_settings
  prefix              = var.prefix == null ? local.global_settings.prefix : var.prefix
  environment         = local.global_settings.environment
  tags_hub            = merge({ "environment" = local.environment }, var.global_settings.tags_hub)
  azure_subscriptions = data.terraform_remote_state.launchpad.outputs.azure_subscriptions
}
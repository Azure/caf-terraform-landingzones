terraform {
  required_version = ">= 0.12.6"
  backend "azurerm" {
  }
}

data "azurerm_subscription" "current" {
}

data "azurerm_client_config" "current" {

}

locals {
  tags = merge(var.tags, var.global_settings.tags_hub)
}

terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
  required_version = ">= 0.13"
}


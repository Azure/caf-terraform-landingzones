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
  blueprint_tag          = {
    "blueprint" = basename(abspath(path.module))
  }
  tags                = merge(var.global_settings.tags_hub,local.blueprint_tag)
}
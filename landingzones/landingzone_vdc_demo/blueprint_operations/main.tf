terraform {
    backend "azurerm" {
    }
}

data "azurerm_subscription" "current" {
}

locals {
  blueprint_tag          = {
    "blueprint" = basename(abspath(path.module))
  }
  tags                = merge(var.global_settings.tags_hub,local.blueprint_tag)
}
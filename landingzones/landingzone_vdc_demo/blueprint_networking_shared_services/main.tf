terraform {
    required_version = ">= 0.12.6"
    backend "azurerm" {
    }
}

data "azurerm_subscription" "current" {
}

locals {
  blueprint_tag          = {
    "blueprint" = basename(abspath(path.module))
  }
  tags                = merge(var.tags,local.blueprint_tag)
}
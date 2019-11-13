terraform {
    backend "azurerm" {
    }
}

provider "azurerm" {
  version = "<= 1.35.0"
}

data "azurerm_subscription" "current" {
}

locals {
  blueprint_tag          = {
    "blueprint" = basename(abspath(path.module))
  }
  tags                = merge(var.tags,local.blueprint_tag)
}
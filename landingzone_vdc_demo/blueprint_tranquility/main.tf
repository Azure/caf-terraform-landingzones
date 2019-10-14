
data "azurerm_client_config" "current" {
}

provider "azurerm" {
  version = "<= 1.35.0"
}

provider "azuread" {
    version = "<=0.6.0"
}

terraform {
    backend "azurerm" {
    }
}

locals {
  blueprint_tag          = {
    "blueprint" = basename(abspath(path.module))
  }
  tags                = merge(var.tags_hub,local.blueprint_tag)
}
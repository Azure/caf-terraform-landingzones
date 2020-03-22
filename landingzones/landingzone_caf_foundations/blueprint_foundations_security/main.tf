data "azurerm_client_config" "current" {
}

# provider "azurerm" {
#   version = "<= 1.44"
# }

provider "azuread" {
    version = "<=0.7.0"
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
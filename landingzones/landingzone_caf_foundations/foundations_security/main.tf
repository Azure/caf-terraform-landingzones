data "azurerm_client_config" "current" {
}

terraform {
  backend "azurerm" {
  }
}

locals {
  blueprint_tag = {
    "blueprint" = basename(abspath(path.module))
  }
  tags = merge(var.tags, var.tags_hub, local.blueprint_tag)
}
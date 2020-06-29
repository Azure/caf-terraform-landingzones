provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
  }
}

locals {
  landingzone_tag = {
    "landingzone" = basename(abspath(path.module))
  }
  tags = merge(var.tags, local.landingzone_tag)
}

data "terraform_remote_state" "level0_launchpad" {
  backend = "azurerm"
  config = {
    storage_account_name = var.lowerlevel_storage_account_name
    container_name       = var.lowerlevel_container_name
    key                  = var.lowerlevel_key
    resource_group_name  = var.lowerlevel_resource_group_name
  }
}

locals {
  prefix      = var.prefix == null ? data.terraform_remote_state.level0_launchpad.outputs.prefix : var.prefix
  environment = lookup(data.terraform_remote_state.level0_launchpad.outputs, "environment", "sandpit")
  tags_hub    = merge({"environment" = local.environment}, var.global_settings.tags_hub)
}
provider "azurerm" {
  features {}
}

provider "azurecaf" {}

terraform {
  required_providers {
    azurerm = "~> 2.20.0"
    null    = "~> 2.1.0"
    tls     = "~> 2.1.1"
  }
}

data "azurerm_subscription" "current" {}
data "azurerm_client_config" "current" {}

data "terraform_remote_state" "launchpad" {
  backend = "azurerm"
  config = {
    storage_account_name  = var.lowerlevel_storage_account_name
    container_name        = var.lowerlevel_container_name
    key                   = var.lowerlevel_key
    resource_group_name   = var.lowerlevel_resource_group_name
  }
}

locals {
  addon_tag = {
    "addon" = basename(abspath(path.module))
  }
  tags                        = merge(var.tags, local.addon_tag)

  global_settings             = data.terraform_remote_state.launchpad.outputs.global_settings

  prefix                      = local.global_settings.prefix

  resource_groups             = data.terraform_remote_state.launchpad.outputs.resource_groups
  log_analytics_workspace_id  = data.terraform_remote_state.launchpad.outputs.log_analytics.id
  diagnostics_map             = data.terraform_remote_state.launchpad.outputs.diagnostics_map

  networking                  = data.terraform_remote_state.launchpad.outputs.networking

  keyvaults                   = data.terraform_remote_state.launchpad.outputs.keyvaults

}

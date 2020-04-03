provider "azurerm" {
  version = "~>2.4.0"
  features {}
}

terraform {
    backend "azurerm" {
    }
}

data "terraform_remote_state" "landingzone_caf_foundations" {
  backend = "azurerm"
  config = {
    storage_account_name  = var.lowerlevel_storage_account_name
    container_name        = var.workspace
    key                   = "landingzone_caf_foundations.tfstate"
    resource_group_name   = var.lowerlevel_resource_group_name
  }
}

locals {  
    prefix                      = data.terraform_remote_state.landingzone_caf_foundations.outputs.prefix
    caf_foundations_accounting  = data.terraform_remote_state.landingzone_caf_foundations.outputs.blueprint_foundations_accounting 
    caf_foundations_security    = data.terraform_remote_state.landingzone_caf_foundations.outputs.blueprint_foundations_security
    global_settings             = data.terraform_remote_state.landingzone_caf_foundations.outputs.global_settings 
}
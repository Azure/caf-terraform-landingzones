terraform {
    required_version = ">= 0.12.6"
    backend "azurerm" {
    }
}


data "terraform_remote_state" "landingzone_vdc_level1" {
  backend = "azurerm"
  config = {
    storage_account_name  = var.lowerlevel_storage_account_name
    container_name        = var.lowerlevel_container_name 
    resource_group_name   = var.lowerlevel_resource_group_name
    key                   = "landingzone_vdc_level1.tfstate"
  }
}

locals {    
    landingzone_tag          = {
      "landingzone" = basename(abspath(path.root))
    }
    
    prefix                    = data.terraform_remote_state.landingzone_vdc_level1.outputs.prefix
    tags                      = merge(data.terraform_remote_state.landingzone_vdc_level1.outputs.tags, local.landingzone_tag)
    blueprint_tranquility     = data.terraform_remote_state.landingzone_vdc_level1.outputs.blueprint_tranquility

    location_map              = local.blueprint_tranquility["location_map"]
    log_analytics_workspace   = local.blueprint_tranquility["log_analytics_workspace"]
    diagnostics_map           = local.blueprint_tranquility["diagnostics_map"]
    resource_group_hub_names  = local.blueprint_tranquility["resource_group_hub_names"]         
}


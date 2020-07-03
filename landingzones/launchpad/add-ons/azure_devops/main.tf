
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
  keyvaults = data.terraform_remote_state.launchpad.outputs.keyvaults
  aad_apps  = data.terraform_remote_state.launchpad.outputs.aad_apps
}

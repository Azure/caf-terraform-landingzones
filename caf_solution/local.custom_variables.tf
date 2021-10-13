locals {
  connectivity_subscription_id = can(local.tfstates[local.custom_variables.virtual_hub_lz_key].subscription_id) ? local.tfstates[local.custom_variables.virtual_hub_lz_key].subscription_id : data.azurerm_client_config.current.subscription_id
  connectivity_tenant_id       = can(local.tfstates[local.custom_variables.virtual_hub_lz_key].tenant_id) ? local.tfstates[local.custom_variables.virtual_hub_lz_key].tenant_id : data.azurerm_client_config.current.tenant_id

  remote_custom_variables = {
    for key, value in try(var.landingzone.tfstates, {}) : "deep_merged_l1" => merge(try(data.terraform_remote_state.remote[key].outputs.custom_variables, {})) ...
  }
  
  custom_variables = merge(
    local.remote_custom_variables.deep_merged_l1[0],
    var.custom_variables
  )

}

output custom_variables {
  value = local.custom_variables
}

output connectivity_subscription_id {
  value = local.connectivity_subscription_id
}

output connectivity_tenant_id {
  value = local.connectivity_tenant_id
}

output virtual_hub_lz_key {
  value = try(local.custom_variables.virtual_hub_lz_key, null)
}
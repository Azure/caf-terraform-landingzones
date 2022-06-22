locals {
  connectivity_subscription_id = can(local.tfstates[local.custom_variables.virtual_hub_lz_key].subscription_id) || can(var.custom_variables.virtual_hub_subscription_id) ? try(var.custom_variables.virtual_hub_subscription_id, local.tfstates[local.custom_variables.virtual_hub_lz_key].subscription_id) : data.azurerm_client_config.current.subscription_id
  connectivity_tenant_id       = can(local.tfstates[local.custom_variables.virtual_hub_lz_key].tenant_id) || can(var.custom_variables.virtual_hub_tenant_id) ? try(var.custom_variables.virtual_hub_tenant_id, local.tfstates[local.custom_variables.virtual_hub_lz_key].tenant_id) : data.azurerm_client_config.current.tenant_id

  remote_custom_variables = {
    for key, value in try(var.landingzone.tfstates, {}) : "deep_merged_l1" => merge(try(data.terraform_remote_state.remote[key].outputs.custom_variables, {}))...
  }
  #
  # Produces the following structure
  # + remote_custom_variables      = {
  #   + deep_merged_l1 = [
  #       + {},
  #       + {
  #           + another_var        = "other"
  #           + virtual_hub_lz_key = "vhub_prod"
  #         },
  #       + {
  #           + ddos_protection_plan = "/subscription/ddos_plan.id"
  #           + virtual_hub_lz_key   = "vhub_prod"
  #         },
  #     ]
  # }

  deep_merged_l1 = {
    for mapping in
    flatten(
      [
        for key, value in try(local.remote_custom_variables.deep_merged_l1, {}) :
        [
          for lkey in keys(value) : {
            value = lookup(value, lkey)
            key   = lkey
          }
        ]
      ]
    ) : mapping.key => mapping.value...
  }
  #
  # Produces the folowing structure
  # + deep_merged_l1               = {
  #   + another_var          = [
  #       + "other",
  #     ]
  #   + ddos_protection_plan = [
  #       + "/subscription/ddos_plan.id",
  #     ]
  #   + virtual_hub_lz_key   = [
  #       + "vhub_prod",
  #       + "vhub_prod",
  #     ]
  # }

  deep_merged_l2 = {
    for mapping in
    flatten(
      [
        for key, value in try(local.deep_merged_l1, {}) :
        {
          key   = key
          value = value[0]
        }
      ]
    ) : mapping.key => mapping.value
  }
  #
  # Produces the following structure
  # + custom_variables             = {
  #   + another_var          = "other"
  #   + ddos_protection_plan = "/subscription/ddos_plan.id"
  #   + virtual_hub_lz_key   = "vhub_prod"
  # }

  custom_variables = merge(
    try(local.deep_merged_l2, {}),
    var.custom_variables
  )

}

output "custom_variables" {
  value = local.custom_variables
}

output "connectivity_subscription_id" {
  value = local.connectivity_subscription_id
}

output "connectivity_tenant_id" {
  value = local.connectivity_tenant_id
}

output "virtual_hub_lz_key" {
  value = try(local.custom_variables.virtual_hub_lz_key, null)
}
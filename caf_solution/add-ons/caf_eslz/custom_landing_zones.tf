data "azurerm_management_group" "id" {
  for_each = var.reconcile_vending_subscriptions ? var.custom_landing_zones : {}

  name = each.key
}

locals {

  custom_landing_zones = {
    for mg_id, mg_value in var.custom_landing_zones : mg_id => {
      display_name               = mg_value.display_name
      parent_management_group_id = mg_value.parent_management_group_id
      subscription_ids           = local.custom_landing_zones_subscription_ids[mg_id].subscription_ids
      archetype_config           = local.custom_landing_zones_archetype_config[mg_id]
    }
  }

  custom_landing_zones_subscription_ids = {
    for mg_id, mg_value in try(var.custom_landing_zones, {}) : mg_id => {

      subscription_ids = try(
        coalescelist(
          try(
            flatten(
              [
                data.azurerm_management_group.id[mg_id].subscription_ids
              ]
            ),
            []
          ),
          flatten(
            [
              for subscription_id in mg_value.subscription_ids : subscription_id
            ]
          )
        ),
        []
      )

    }
  }

  custom_landing_zones_archetype_config = {
    for mg_id, mg_value in try(var.custom_landing_zones, {}) : mg_id => {

      archetype_id = mg_value.archetype_config.archetype_id

      access_control = {
        for mapping in
        flatten(
          [
            for role, roles in try(mg_value.archetype_config.access_control, {}) : {
              role = role
              ids = coalescelist(
                flatten(
                  [
                    for resource_type, value in roles : [
                      for resource_key in try(value.resource_keys, []) : [
                        local.caf[resource_type][value.lz_key][resource_key][value.attribute_key]
                      ]
                    ]
                  ]
                ) //flatten
                ,
                flatten(
                  [
                    for principal_id in try(roles.principal_ids, []) : [
                      principal_id
                    ]
                  ]
                ) //flatten
              )   //coalescelist (ids)
            }
          ]
        ) : mapping.role => mapping.ids
      }

      parameters = {
        for param_key, param_value in try(mg_value.archetype_config.parameters, {}) : param_key => {
          for key, value in param_value : key => jsonencode(try(local.caf[value.output_key][value.lz_key][value.resource_type][value.resource_key][value.attribute_key], value.value))
        }
      }

    }
  }
}

locals {

  archetype_config_overrides = {
    for mg_id, mg_value in try(var.archetype_config_overrides, {}) : mg_id => {

      archetype_id = mg_value.archetype_id

      access_control = {
        for mapping in
        flatten(
          [
            for role, roles in try(mg_value.access_control, {}) : {
              role = role
              ids = flatten(
                [
                  [
                    for resource_type, value in roles : [
                      for resource_key in try(value.resource_keys, []) : [
                        local.caf[resource_type][value.lz_key][resource_key][value.attribute_key]
                      ]
                    ]
                  ],
                  [
                    roles.principal_ids != null ? try(roles.principal_ids, []) : []
                  ]
                ]
              ) //flatten (ids)
            }
          ]
        ) : mapping.role => mapping.ids
      }

      parameters = local.aco_parameters_combined[mg_id]
    }
  }

  aco_parameters_combined = {
    for mg_id, mg_value in try(var.archetype_config_overrides, {}) : mg_id => {
      for param_key, param_value in try(mg_value.parameters, {}) : param_key => merge(
        local.aco_parameters_value[mg_id][param_key],
        local.aco_parameters_values[mg_id][param_key],
        local.aco_parameters_integer[mg_id][param_key],
        local.aco_parameters_boolean[mg_id][param_key],
        local.aco_parameters_hcl_jsonencoded[mg_id][param_key],
        local.aco_parameters_remote_lz[mg_id][param_key]
      )
    }
  }

  aco_parameters_value = {
    for mg_id, mg_value in try(var.archetype_config_overrides, {}) : mg_id => {
      for param_key, param_value in try(mg_value.parameters, {}) : param_key => {
        for key, value in param_value : key => value.value
        if value.value != null
      }
    }
  }

  aco_parameters_values = {
    for mg_id, mg_value in try(var.archetype_config_overrides, {}) : mg_id => {
      for param_key, param_value in try(mg_value.parameters, {}) : param_key => {
        for key, value in param_value : key => value.values
        if value.values != null
      }
    }
  }

  aco_parameters_integer = {
    for mg_id, mg_value in try(var.archetype_config_overrides, {}) : mg_id => {
      for param_key, param_value in try(mg_value.parameters, {}) : param_key => {
        for key, value in param_value : key => value.integer
        if value.integer != null
      }
    }
  }

  aco_parameters_boolean = {
    for mg_id, mg_value in try(var.archetype_config_overrides, {}) : mg_id => {
      for param_key, param_value in try(mg_value.parameters, {}) : param_key => {
        for key, value in param_value : key => value.boolean
        if value.boolean != null
      }
    }
  }

  aco_parameters_hcl_jsonencoded = {
    for mg_id, mg_value in try(var.archetype_config_overrides, {}) : mg_id => {
      for param_key, param_value in try(mg_value.parameters, {}) : param_key => {
        for key, value in param_value : key => jsondecode(value.hcl_jsonencoded)
        if value.hcl_jsonencoded != null
      }
    }
  }

  aco_parameters_remote_lz = {
    for mg_id, mg_value in try(var.archetype_config_overrides, {}) : mg_id => {
      for param_key, param_value in try(mg_value.parameters, {}) : param_key => {
        for key, value in param_value : key => local.caf[value.output_key][value.lz_key][value.resource_type][value.resource_key][value.attribute_key]
        if value.output_key != null
      }
    }
  }

}

# output caf {
#   value       = local.caf
# }


## Process the following variable

# archetype_config_overrides = {

#   root = {                        // var.root_id
#     archetype_id   = "es_root"
#     parameters     = {
#       "Deploy-Resource-Diag" = {
#         "logAnalytics" = {
#           # value = "resource_id"
#           lz_key        = "caf_foundations_sharedservices"
#           output_key    = "diagnostics"
#           resource_type = "log_analytics"
#           resource_key  = "eus_logs_ss"
#           attribute_key = "id"
#         }
#       }
#     }
#     access_control = {
#       "Contributor" = {
#         "managed_identities" = {
#           # principal_ids = ["principal_id1", "principal_id2"]
#           lz_key        = "launchpad"
#           attribute_key = "principal_id"
#           resource_keys = [
#             "level1"
#           ]
#         }
#       }
#     }
#   } //root

#   # decommissioned = {}
#   # sandboxes = {}
#   # landing-zones = {}
#   # platform = {}
#   # connectivity = {}
#   # management = {}
# }
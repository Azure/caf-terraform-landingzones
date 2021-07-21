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
                    try(roles.principal_ids, [])
                  ]
                ]
              ) //flatten (ids)
            }
          ]
        ) : mapping.role => mapping.ids
      }

      parameters = {
        for param_key, param_value in try(mg_value.parameters, {}) : param_key => {
          for key, value in param_value : key => jsonencode(try(local.caf[value.output_key][value.lz_key][value.resource_type][value.resource_key][value.attribute_key], value.value))
        }

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
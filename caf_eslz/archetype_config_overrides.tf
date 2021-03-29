locals {

  archetype_config_overrides = {         
    for mg_id , mg_value in  try(var.archetype_config_overrides, {}) : mg_id => {      
      archetype_id   = mg_value.archetype_id   
      access_control = try(mg_value.access_control, {})
      parameters     = {
        for param_key, param_value in try(mg_value.parameters, {}) : param_key => {
          for key, value in param_value : key =>  try(local.caf[value.output_key][value.lz_key][value.resource_type][value.resource_key][value.attribute_key], value)
        }
      }
    }
  }

}

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
#     access_control = {}
#   } //root

#   # decommissioned = {}
#   # sandboxes = {}
#   # landing-zones = {}
#   # platform = {}
#   # connectivity = {}
#   # management = {}
# }
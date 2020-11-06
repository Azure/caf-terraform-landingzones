landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "launchpad"
  level               = "level1"
  key                 = "caf_foundations"
  tfstates = {
    launchpad = {
      level   = "lower"
      tfstate = "caf_launchpad.tfstate"
    }
  }
}

enterprise_scale = {
  #path to the policies definition and assignment repo
  library_path = "/scenario/200/lib"

  #management groups hierarchy configuration
  management_groups = {
    caf = {
      display_name               = "CAF-RootManagementGroup"
      parent_management_group_id = ""
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "es_root"
        parameters     = {}
        access_control = {}
      }
    }
    child-caf = {
      display_name               = "CAF-ChildManagementGroup"
      parent_management_group_id = "caf"
      subscription_ids           = []
      archetype_config = {
        archetype_id = "es_management"
        parameters = {
          ES-Deploy-ForwardDiagLog = {
            logAnalytics = "central_logs_region1"
          }
        }
        access_control = {}
      }
    }
  }
}
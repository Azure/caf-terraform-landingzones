landingzone = {
  backend_type = "azurerm"
  current = {
    level = "level1"
    key   = "caf_foundations"
  }
  lower = {
    launchpad = {
      tfstate = "caf_launchpad.tfstate"
    }
  }
}

enterprise_scale = {
  #path to the policies definition and assignment repo
  library_path = "/scenario/200/lib"

  #management groups hierarchy configuration
  management_groups = {
    root-caf = {
      display_name               = "CAF-RootManagementGroup"
      parent_management_group_id = ""
      subscription_ids           = []
      archetype_config = {
        archetype_id = "es_custom"
        parameters   = {}
        access_control = {}
      }
    }
    child-caf = {
      display_name               = "CAF-ChildManagementGroup"
      parent_management_group_id = "root-caf"
      subscription_ids           = []
      archetype_config = {
        archetype_id = "es_management"
        parameters   = {
          ES-Deploy-ForwardDiagLog = {
           logAnalytics = "central_logs_region1"
          }
        }
        access_control = {}
      }
    }
  }
}
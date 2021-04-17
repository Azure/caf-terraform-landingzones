landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "caf_foundations_sharedservices"
  level               = "level1"
  key                 = "caf_foundations_enterprise_scale"
  tfstates = {
    // Remote tfstate to retrieve default location and log analytics workspace
    caf_foundations_sharedservices = {
      level   = "current"
      tfstate = "caf_foundations_sharedservices.tfstate"
    }
    // Remote tfstate to retrieve the MSI created by the launchpad and set permissions on the MG hierarchy
    // Requires scenarion 200  to get access to Log Analytics key 'central_logs_region1'
    launchpad = {
      level   = "lower"
      tfstate = "caf_launchpad.tfstate"
    }
  }
}
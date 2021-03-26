landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "launchpad"
  level               = "level1"
  key                 = "caf_eslz"
  tfstates = {
    launchpad = {
      level   = "lower"
      tfstate = "caf_launchpad.tfstate"
    }
  }
}

enterprise_scale = {
  # Define a custom ID to use for the root Management Group
  # Also used as a prefix for all core Management Group IDs
  # root_id      = "caf"
  # root_name    = "CAF-RootManagementGroup"

  # Control whether to deploy the default core landing zones // default = true
  deploy_core_landing_zones = true

  # Control whether to deploy the demo landing zones // default = false
  deploy_demo_landing_zones = false
}
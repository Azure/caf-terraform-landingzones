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
  #key of the log analytics repo from launchpad configuration
  log_analytics_key = "central_logs_region1"
}
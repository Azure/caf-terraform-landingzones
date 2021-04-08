landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "caf_foundations"
  level               = "level2"
  key                 = "networking_hub"
  tfstates = {
    caf_foundations = {
      level   = "lower"
      tfstate = "caf_foundations.tfstate"
    }
  }
}

resource_groups = {
  vnet_hub_re1 = {
    name   = "vnet-hub-re1"
    region = "region1"
  }
  vnet_hub_re2 = {
    name   = "vnet-hub-re2"
    region = "region2"
  }
}

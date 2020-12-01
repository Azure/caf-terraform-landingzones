landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "foundations"
  level               = "level2"
  key                 = "launchpad"
  tfstates = {
    foundations = {
      level   = "lower"
      tfstate = "caf_foundations.tfstate"
    }
    launchpad = {
      level   = "lower"
      tfstate = "caf_foundations.tfstate"
    }
    networking_hub = {
      tfstate = "caf_networking.tfstate"
    }
  }
}

vnet_peerings = {

  # Inbound peer with the devops vnet
  launchpad_devops-TO-hub_rg1 = {
    from = {
      vnet_key = "devops_region1"
    }
    to = {
      lz_key     = "networking_hub"
      output_key = "vnets"
      vnet_key   = "hub_rg1"
    }
    name                         = "launchpad_devops-TO-hub_rg1"
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }

}


landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "foundations"
  level               = "level2"
  key                 = "example"
  tfstates = {
    foundations = {
      level   = "lower"
      tfstate = "caf_foundations.tfstate"
    }
    launchpad = {
      level   = "lower"
      tfstate = "caf_foundations.tfstate"
    }
  }
}

resource_groups = {
  vnet_re1 = {
    name   = "vnet-spoke-re1"
    region = "region1"
  }
  hub_re1 = {
    name   = "vnet-hub-re1"
    region = "region1"
  }
}

vnets = {
  vnet_re1 = {
    resource_group_key = "vnet_re1"
    region             = "region1"
    vnet = {
      name          = "hub-re1"
      address_space = ["10.10.100.0/24"]
    }
    specialsubnets = {
      AzureFirewallSubnet = {
        name = "AzureFirewallSubnet" #Must be called AzureFirewallSubnet
        cidr = ["10.10.100.192/26"]
      }
    }
    subnets = {
      AzureBastionSubnet = {
        name    = "AzureBastionSubnet" #Must be called AzureBastionSubnet
        cidr    = ["10.10.100.160/27"]
        nsg_key = "azure_bastion_nsg"
      }
    }
  }
}

vhub_peerings = {
  # Establish the peering with Virtual Hubs
  hub_rg1-TO-vnet_rg1 = {
    vhub = {
      virtual_wan_key = "vwan_re1"
      virtual_hub_key = "hub_re1"
    }
    vnet = {
      # If the virtual network is stored in another another landing zone, use the following attributes to refer the state file:
      # tfstate_key = "networking"
      # lz_key      = "networking"
      # output_key  = "vnets"
      vnet_key = "vnet_re1"
    }
    name                                           = "vhub_peering_hub_sg"
    hub_to_vitual_network_traffic_allowed          = true
    vitual_network_to_hub_gateways_traffic_allowed = true
    internet_security_enabled                      = true
  }
}

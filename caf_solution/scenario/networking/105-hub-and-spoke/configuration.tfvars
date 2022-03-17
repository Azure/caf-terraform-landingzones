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
  vnet_hub_region1 = {
    name = "vnet-hub-re1"
  }
  vnet_spoke_region1 = {
    name = "vnet-spoke-re1"
  }
}

vnets = {
  hub_re1 = {
    resource_group_key = "vnet_hub_region1"
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
      jumphost = {
        name    = "jumphost"
        cidr    = ["10.10.100.0/25"]
        nsg_key = "jumphost"
      }
    }
  }

  spoke_re1 = {
    resource_group_key = "vnet_spoke_region1"
    vnet = {
      name          = "spoke-re1"
      address_space = ["10.11.100.0/24"]
    }
    specialsubnets = {}
    subnets = {
      jumphost = {
        name    = "jumphost"
        cidr    = ["10.11.100.0/25"]
        nsg_key = "jumphost"
      }
      webapp1 = {
        name = "webapp-presentation-tier"
        cidr = ["10.11.100.128/25"]
      }
    }
  }
}

azurerm_firewalls = {
  # firewall (do not change the key when created)
  fw_re1 = {
    region             = "region1"
    name               = "azfwre1"
    resource_group_key = "vnet_hub_region1"
    vnet_key           = "hub_re1"
    public_ip_key      = "az_fw_pip"

  }

}

public_ip_addresses = {

  az_fw_pip = {
    name                    = "az_fw_re1_pip1"
    region                  = "region1"
    resource_group_key      = "vnet_hub_region1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"

  }
}

route_tables = {
  default_to_firewall_re1 = {
    name               = "default_to_firewall_re1"
    resource_group_key = "vnet_spoke_region1"
  }
}

azurerm_routes = {
  default_to_firewall_rg1 = {
    name               = "0-0-0-0-through-firewall-re1"
    resource_group_key = "vnet_spoke_region1"
    route_table_key    = "default_to_firewall_re1"
    address_prefix     = "0.0.0.0/0"
    next_hop_type      = "VirtualAppliance"

    # To be set when next_hop_type = "VirtualAppliance"
    private_ip_keys = {
      azurerm_firewall = {
        key             = "fw_re1"
        interface_index = 0
      }
      # virtual_machine = {
      #   key = ""
      #   nic_key = ""
      # }
    }
  }
}

vnet_peerings = {
  hub-re1_TO_spoke-re1 = {
    name = "hub-re1_TO_spoke-re1"
    from = {
      vnet_key = "hub_re1"
    }
    to = {
      vnet_key = "spoke_re1"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = true
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }

  spoke-re1_TO_hub-re1 = {
    name = "hub_re2_TO_hub_re1"
    from = {
      vnet_key = "spoke_re1"
    }
    to = {
      vnet_key = "hub_re1"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }

}

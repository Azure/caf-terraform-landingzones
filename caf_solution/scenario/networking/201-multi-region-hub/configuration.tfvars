landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "caf_gitops"
  level               = "level2"
  key                 = "networking_hub"
  tfstates = {
    caf_gitops = {
      level   = "lower"
      tfstate = "caf_foundations.tfstate"
    }
  }
}

resource_groups = {
  vnet_hub_rg1 = {
    name   = "vnet-hub-rg1"
    region = "region1"
  }
  vnet_hub_rg2 = {
    name   = "vnet-hub-rg2"
    region = "region2"
  }
}

vnets = {
  hub_rg1 = {
    resource_group_key = "vnet_hub_rg1"
    region             = "region1"
    vnet = {
      name          = "hub-rg1"
      address_space = ["100.64.92.0/22"]
    }
    specialsubnets = {
      GatewaySubnet = {
        name = "GatewaySubnet" #Must be called GateWaySubnet in order to host a Virtual Network Gateway
        cidr = ["100.64.92.0/27"]
      }
      AzureFirewallSubnet = {
        name = "AzureFirewallSubnet" #Must be called AzureFirewallSubnet
        cidr = ["100.64.93.0/26"]
      }
    }
    subnets = {
      AzureBastionSubnet = {
        name    = "AzureBastionSubnet" #Must be called AzureBastionSubnet
        cidr    = ["100.64.93.64/26"]
        nsg_key = "azure_bastion_nsg"
      }
      jumpbox = {
        name    = "jumpbox"
        cidr    = ["100.64.94.0/27"]
        nsg_key = "jumpbox"
      }
      private_endpoints = {
        name                                           = "private_endpoints"
        cidr                                           = ["100.64.95.128/25"]
        enforce_private_link_endpoint_network_policies = true
      }
    }

    # you can setup up to 5 keys - vnet diganostic
    diagnostic_profiles = {
      vnet = {
        definition_key   = "networking_all"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

  }

  hub_rg2 = {
    resource_group_key = "vnet_hub_rg2"
    region             = "region2"
    vnet = {
      name          = "hub-rg2"
      address_space = ["100.65.100.0/22"]
    }
    specialsubnets = {
      GatewaySubnet = {
        name = "GatewaySubnet" #Must be called GateWaySubnet in order to host a Virtual Network Gateway
        cidr = ["100.65.100.0/27"]
      }
      AzureFirewallSubnet = {
        name = "AzureFirewallSubnet" #Must be called AzureFirewallSubnet
        cidr = ["100.65.101.0/26"]
      }
    }
    subnets = {
      AzureBastionSubnet = {
        name    = "AzureBastionSubnet" #Must be called AzureBastionSubnet
        cidr    = ["100.65.101.64/26"]
        nsg_key = "azure_bastion_nsg"
      }
      jumpbox = {
        name    = "jumpbox"
        cidr    = ["100.65.102.0/27"]
        nsg_key = "jumpbox"
      }
      private_endpoints = {
        name                                           = "private_endpoints"
        cidr                                           = ["100.65.103.128/25"]
        enforce_private_link_endpoint_network_policies = true
      }
    }

    # you can setup up to 5 keys - vnet diganostic
    diagnostic_profiles = {
      vnet = {
        definition_key   = "networking_all"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

  }


}

vnet_peerings = {
  hub_rg1_TO_hub_rg2 = {
    name = "hub_rg1_TO_hub_rg2"
    from = {
      vnet_key = "hub_rg1"
    }
    to = {
      vnet_key = "hub_rg2"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }

  hub_rg2_TO_hub_rg1 = {
    name = "hub_rg2_TO_hub_rg1"
    from = {
      vnet_key = "hub_rg2"
    }
    to = {
      vnet_key = "hub_rg1"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }

  # Establish a peering with the devops vnet
  hub_rg1-TO-launchpad_devops = {
    name = "hub_rg1-TO-devops_region1"
    from = {
      vnet_key = "hub_rg1"
    }
    to = {
      lz_key     = "caf_gitops"
      output_key = "vnets"
      vnet_key   = "devops_region1"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }

  # Inbound peer with the devops vnet
  launchpad_devops-TO-hub_rg1 = {
    name = "launchpad_devops-TO-hub_rg1"
    from = {
      lz_key     = "caf_gitops"
      output_key = "vnets"
      vnet_key   = "devops_region1"
    }
    to = {
      vnet_key = "hub_rg1"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }


  # Establish a peering with the devops vnet
  hub_rg2-TO-launchpad_devops = {
    name = "hub_rg2-TO-devops_region1"
    from = {
      vnet_key = "hub_rg2"
    }
    to = {
      lz_key     = "caf_gitops"
      output_key = "vnets"
      vnet_key   = "devops_region1"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }

  # Inbound peer with the devops vnet
  launchpad_devops-TO-hub_rg2 = {
    name = "launchpad_devops-TO-hub_rg2"
    from = {
      lz_key     = "caf_gitops"
      output_key = "vnets"
      vnet_key   = "devops_region1"
    }
    to = {
      vnet_key = "hub_rg2"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }


}

public_ip_addresses = {

  bastion_host_rg1 = {
    name                    = "bastion-rg1-pip1"
    region                  = "region1"
    resource_group_key      = "vnet_hub_rg1"
    sku                     = "Standard"
    zones                   = ["1", "2", "3"]
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"

    # you can setup up to 5 key
    diagnostic_profiles = {
      bastion_host_rg1 = {
        definition_key   = "public_ip_address"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }

  bastion_host_rg2 = {
    name                    = "bastion-rg2-pip1"
    region                  = "region2"
    resource_group_key      = "vnet_hub_rg2"
    sku                     = "Standard"
    zones                   = []
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"

    # you can setup up to 5 key
    diagnostic_profiles = {
      bastion_host_rg2 = {
        definition_key   = "public_ip_address"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

  }

}


bastion_hosts = {
  bastion_hub_rg1 = {
    name               = "bastion-rg1"
    region             = "region1"
    resource_group_key = "vnet_hub_rg1"
    vnet_key           = "hub_rg1"
    subnet_key         = "AzureBastionSubnet"
    public_ip_key      = "bastion_host_rg1"

    # you can setup up to 5 profiles
    diagnostic_profiles = {
      operations = {
        definition_key   = "bastion_host"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }

  bastion_hub_rg2 = {
    name               = "bastion-rg2"
    region             = "region2"
    resource_group_key = "vnet_hub_rg2"
    vnet_key           = "hub_rg2"
    subnet_key         = "AzureBastionSubnet"
    public_ip_key      = "bastion_host_rg2"

    # you can setup up to 5 profiles
    diagnostic_profiles = {
      operations = {
        definition_key   = "bastion_host"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }

}


#
# Definition of the networking security groups
#
network_security_group_definition = {
  # This entry is applied to all subnets with no NSG defined
  empty_nsg = {

    diagnostic_profiles = {
      nsg = {
        definition_key   = "network_security_group"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
      operations = {
        name             = "operations"
        definition_key   = "network_security_group"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }

  azure_bastion_nsg = {

    diagnostic_profiles = {
      nsg = {
        definition_key   = "network_security_group"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
      operations = {
        name             = "operations"
        definition_key   = "network_security_group"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

    nsg = [
      {
        name                       = "bastion-in-allow",
        priority                   = "100"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "bastion-control-in-allow-443",
        priority                   = "120"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "135"
        source_address_prefix      = "GatewayManager"
        destination_address_prefix = "*"
      },
      {
        name                       = "Kerberos-password-change",
        priority                   = "121"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "4443"
        source_address_prefix      = "GatewayManager"
        destination_address_prefix = "*"
      },
      {
        name                       = "bastion-vnet-out-allow-22",
        priority                   = "103"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "bastion-vnet-out-allow-3389",
        priority                   = "101"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "bastion-azure-out-allow",
        priority                   = "120"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureCloud"
      }
    ]
  }

  application_gateway = {

    # diagnostic_profiles = {
    #   nsg = {
    #     definition_key   = "network_security_group"
    #     destination_type = "storage"
    #     destination_key  = "all_regions"
    #   }
    #   operations = {
    #     name             = "operations"
    #     definition_key   = "network_security_group"
    #     destination_type = "log_analytics"
    #     destination_key  = "central_logs"
    #   }
    # }

    nsg = [
      {
        name                       = "Inbound-HTTP",
        priority                   = "120"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "80-82"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Inbound-HTTPs",
        priority                   = "130"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Inbound-AGW",
        priority                   = "140"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "65200-65535"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
    ]
  }

  api_management = {

    # diagnostic_profiles = {
    #   nsg = {
    #     definition_key   = "network_security_group"
    #     destination_type = "storage"
    #     destination_key  = "all_regions"
    #   }
    #   operations = {
    #     name             = "operations"
    #     definition_key   = "network_security_group"
    #     destination_type = "log_analytics"
    #     destination_key  = "central_logs"
    #   }
    # }

    nsg = [
      {
        name                       = "Inbound-APIM",
        priority                   = "100"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "3443"
        source_address_prefix      = "ApiManagement"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "Inbound-Redis",
        priority                   = "110"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "6381-6383"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "Inbound-LoadBalancer",
        priority                   = "120"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "AzureLoadBalancer"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "Outbound-StorageHttp",
        priority                   = "100"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "Storage"
      },
      {
        name                       = "Outbound-StorageHttps",
        priority                   = "110"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "Storage"
      },
      {
        name                       = "Outbound-AADHttp",
        priority                   = "120"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "AzureActiveDirectory"
      },
      {
        name                       = "Outbound-AADHttps",
        priority                   = "130"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "AzureActiveDirectory"
      },
      {
        name                       = "Outbound-SQL",
        priority                   = "140"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "1433"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "SQL"
      },
      {
        name                       = "Outbound-EventHub",
        priority                   = "150"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "5671-5672"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "EventHub"
      },
      {
        name                       = "Outbound-EventHubHttps",
        priority                   = "160"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "EventHub"
      },
      {
        name                       = "Outbound-FileShareGit",
        priority                   = "170"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "445"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "Storage"
      },
      {
        name                       = "Outbound-Health",
        priority                   = "180"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "1886"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "INTERNET"
      },
      {
        name                       = "Outbound-Monitor",
        priority                   = "190"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "AzureMonitor"
      },
      {
        name                       = "Outbound-MoSMTP1itor",
        priority                   = "200"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "25"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "INTERNET"
      },
      {
        name                       = "Outbound-SMTP2",
        priority                   = "210"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "587"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "INTERNET"
      },
      {
        name                       = "Outbound-SMTP3",
        priority                   = "220"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "25028"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "INTERNET"
      },
      {
        name                       = "Outbound-Redis",
        priority                   = "230"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "6381-6383"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "VirtualNetwork"
      },
    ]
  }

  jumpbox = {

    diagnostic_profiles = {
      nsg = {
        definition_key   = "network_security_group"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
      operations = {
        name             = "operations"
        definition_key   = "network_security_group"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

    nsg = [
      {
        name                       = "ssh-inbound-22",
        priority                   = "200"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
      },
    ]
  }

}


#
# Define the settings for the diagnostics settings
# Demonstrate how to log diagnostics in the correct region
# Different profiles to target different operational teams
#
diagnostics_definition = {
  azurerm_firewall = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AzureFirewallApplicationRule", true, true, 0],
        ["AzureFirewallNetworkRule", true, true, 0],
        ["AzureFirewallDnsProxy", true, true, 0],
      ]
      metric = [
        ["AllMetrics", true, true, 0],
      ]
    }
  }

  public_ip_address = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["DDoSProtectionNotifications", true, true, 0],
        ["DDoSMitigationFlowLogs", true, true, 0],
        ["DDoSMitigationReports", true, true, 0],
      ]
      metric = [
        ["AllMetrics", true, true, 0],
      ]
    }
  }

  azure_container_registry = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["ContainerRegistryRepositoryEvents", true, false, 0],
        ["ContainerRegistryLoginEvents", true, false, 0],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 0],
      ]
    }
  }

}

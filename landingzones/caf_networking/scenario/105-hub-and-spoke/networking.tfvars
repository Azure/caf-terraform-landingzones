global_settings = {
  regions = {
    region1 = "eastasia"
  }
}

tfstates = {
  caf_foundations = {
    tfstate = "caf_foundations.tfstate"
  }
  networking = {
    tfstate = "caf_foundations.tfstate"
  }
}

resource_groups = {
  vnet_region1 = {
    name = "vnet-hub"
  }
}

vnets = {
  hub_sg = {
    resource_group_key = "vnet_region1"
    vnet = {
      name          = "hub"
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

  hub_sg = {
    resource_group_key = "vnet_region1"
    vnet = {
      name          = "spoke"
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

# firewalls = {
#   # Southeastasia firewall (do not change the key when created)
#   southeastasia = {
#     location           = "southeastasia"
#     resource_group_key = "vnet_sg"
#     vnet_key           = "hub_sg"

#     # Settings for the public IP address to be used for Azure Firewall
#     # Must be standard and static for
#     firewall_ip_addr_config = {
#       ip_name           = "firewall"
#       allocation_method = "Static"
#       sku               = "Standard" #defaults to Basic
#       ip_version        = "IPv4"     #defaults to IP4, Only dynamic for IPv6, Supported arguments are IPv4 or IPv6, NOT Both
#       diagnostics = {
#         log = [
#           #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
#           ["DDoSProtectionNotifications", true, true, 30],
#           ["DDoSMitigationFlowLogs", true, true, 30],
#           ["DDoSMitigationReports", true, true, 30],
#         ]
#         metric = [
#           ["AllMetrics", true, true, 30],
#         ]
#       }
#     }

#     # Settings for the Azure Firewall settings
#     az_fw_config = {
#       name = "azfw"
#       diagnostics = {
#         log = [
#           #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
#           ["AzureFirewallApplicationRule", true, true, 30],
#           ["AzureFirewallNetworkRule", true, true, 30],
#         ]
#         metric = [
#           ["AllMetrics", true, true, 30],
#         ]
#       }
#     }

#   }

# }


#
# Definition of the networking security groups
#
network_security_group_definition = {
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

  jumphost = {

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

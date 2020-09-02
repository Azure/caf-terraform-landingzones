resource_groups = {
  vnet_sg = {
    name       = "vnet-sg"
    location   = "southeastasia"
    useprefix  = true
    max_length = 40
  }
}

vnets = {
  hub_sg = {
    resource_group_key = "vnet_sg"
    location           = "southeastasia"
    vnet = {
      name          = "hub"
      address_space = ["10.10.100.0/24"]
    }
    specialsubnets = {
      GatewaySubnet = {
        name = "GatewaySubnet" #Must be called GateWaySubnet in order to host a Virtual Network Gateway
        cidr = ["10.10.100.224/27"]
      }
      AzureFirewallSubnet = {
        name = "AzureFirewallSubnet" #Must be called AzureFirewallSubnet 
        cidr = ["10.10.100.192/27"]
      }
    }
    subnets = {
      Active_Directory = {
        name     = "Active_Directory"
        cidr     = ["10.10.100.0/27"]
        nsg_name = "Active_Directory_nsg"
        nsg      = []
      }
      AzureBastionSubnet = {
        name     = "AzureBastionSubnet" #Must be called AzureBastionSubnet 
        cidr     = ["10.10.100.160/27"]
        nsg_name = "AzureBastionSubnet_nsg"
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
            name                       = "bastion-control-in-allow-4443",
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
    }
    # Override the default var.diagnostics.vnet
    diagnostics = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
        ["VMProtectionAlerts", true, true, 60],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]                 
        ["AllMetrics", true, true, 60],
      ]
    }
  }

  spoke_aks_sg = {
    resource_group_key = "vnet_sg"
    location           = "southeastasia"
    vnet = {
      name          = "aks"
      address_space = ["10.10.101.0/24"]
    }
    specialsubnets = {}
    subnets = {
      aks_nodepool_system = {
        name     = "aks_nodepool_system"
        cidr     = ["10.10.101.0/27"]
        nsg_name = "aks_nodepool_system_nsg"
        nsg      = []
      }
      aks_nodepool_user1 = {
        name     = "aks_nodepool_user1"
        cidr     = ["10.10.101.32/27"]
        nsg_name = "aks_nodepool_user1_nsg"
        nsg      = []
      }
    }
  }

}

peerings = {
  hub_sg_TO_spoke_aks_sg = {
    from_key                     = "hub_sg"
    to_key                       = "spoke_aks_sg"
    name                         = "hub_sg_TO_spoke_aks_sg"
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }

  spoke_aks_sg_TO_hub_sg = {
    from_key                     = "spoke_aks_sg"
    to_key                       = "hub_sg"
    name                         = "spoke_aks_sg_TO_hub_sg"
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }
}
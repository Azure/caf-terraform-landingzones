# settings for the shared network blueprint 
resource_groups_shared_services = {
  HUB-CORE-NET = {
    name     = "-hub-network-shared"
    location = "southeastasia"
  }
}

enable_ddos_standard = false
ddos_name            = "ddos_protection_plan"

shared_services_vnet = {
  vnet = {
    name          = "Shared-Services"
    address_space = ["10.101.4.0/22"]
    dns           = []
  }
  specialsubnets = {
  }
  subnets = {
    subnet0 = {
      name              = "Critical_Applications"
      cidr              = ["10.101.4.0/25"]
      nsg_name          = "Critical_Applications_nsg"
      service_endpoints = []
    }
    subnet1 = {
      name              = "Active_Directory"
      cidr              = ["10.101.4.128/27"]
      service_endpoints = []
      nsg_name          = "Active_Directory_nsg"
      nsg = [
        {
          name                       = "W32Time",
          priority                   = "100"
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "UDP"
          source_port_range          = "*"
          destination_port_range     = "123"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "RPC-Endpoint-Mapper",
          priority                   = "101"
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "UDP"
          source_port_range          = "*"
          destination_port_range     = "135"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "Kerberos-password-change",
          priority                   = "102"
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "464"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "RPC-Dynamic-range",
          priority                   = "103"
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "tcp"
          source_port_range          = "*"
          destination_port_range     = "49152-65535"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "LDAP",
          priority                   = "104"
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "389"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "LDAP-SSL",
          priority                   = "105"
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "tcp"
          source_port_range          = "*"
          destination_port_range     = "636"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "LDAP-GC",
          priority                   = "106"
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "tcp"
          source_port_range          = "*"
          destination_port_range     = "3268"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "LDAP-GC-SSL",
          priority                   = "107"
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "tcp"
          source_port_range          = "*"
          destination_port_range     = "3269"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "DNS",
          priority                   = "108"
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "53"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "Kerberos",
          priority                   = "109"
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "88"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "SMB",
          priority                   = "110"
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "tcp"
          source_port_range          = "*"
          destination_port_range     = "445"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    }
    subnet2 = {
      name              = "SQL_Servers"
      cidr              = ["10.101.4.160/27"]
      service_endpoints = []
      nsg_name          = "Data_tier_nsg"
      nsg = [
        {
          name                       = "TDS-In",
          priority                   = "100"
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "UDP"
          source_port_range          = "*"
          destination_port_range     = "1433"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    }
    subnet4 = {
      name     = "AzureBastionSubnet"
      cidr     = ["10.101.4.192/27"]
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
  }
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

## settings for Azure bastion configuration
## not enabled, uncomment the code in the networking shared services blueprint.
enable_bastion = true
bastion_config = {
  name = "azurebastion"
  diagnostics = {
    log = [
      #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
      ["BastionAuditLogs", true, true, 30],
    ]
    metric = [
      #    ["AllMetrics", true, true, 30],
    ]
  }
  ip_name = "caf-pip-bastion"
  ip_addr = {
    allocation_method = "Static"
    #Dynamic Public IP Addresses aren't allocated until they're assigned to a resource (such as a Virtual Machine or a Load Balancer) by design within Azure 

    #properties below are optional 
    sku        = "Standard" #defaults to Basic
    ip_version = "IPv4"     #defaults to IP4, Only dynamic for IPv6, Supported arguments are IPv4 or IPv6, NOT Both
    #dns_prefix          = "arnaudmytest" 
    #timeout             = 15                                #TCP timeout for idle connections. The value can be set between 4 and 30 minutes.
    #zones               = [1]                               #1 zone number, IP address must be standard, ZoneRedundant argument is not supported in provider at time of writing
    #reverse_fqdn        = ""   
    #public_ip_prefix_id = "/subscriptions/00000000-00000-0000-0000-000000000000/resourceGroups/uqvh-hub-ingress-net/providers/Microsoft.Network/publicIPPrefixes/myprefix"
    #refer to the prefix and check sku types are same in IP and prefix 
  }
  ip_diags = {
    log = [
      #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
      ["DDoSProtectionNotifications", true, true, 30],
      ["DDoSMitigationFlowLogs", true, true, 30],
      ["DDoSMitigationReports", true, true, 30],
    ]
    metric = [
      ["AllMetrics", true, true, 30],
    ]
  }
}


# settings for the shared egress blueprint 
resource_groups_shared_egress = {
  HUB-EGRESS-NET = {
    name     = "-hub-network-egress"
    location = "southeastasia"
  }
}

# Settings for the shared services egress vnet - note that Azure Firewall subnet must be at least /26 
networking_egress = {
  vnet = {
    name          = "Shared-Egress"
    address_space = ["10.0.0.0/25"]
    dns           = ["192.168.0.16", "192.168.0.64"]
  }
  specialsubnets = {
    AzureFirewallSubnet = {
      name              = "AzureFirewallSubnet"
      cidr              = ["10.0.0.0/26"]
      service_endpoints = []
    }
  }
  subnets = {
    subnet1 = {
      name     = "Network_Monitoring"
      cidr     = ["10.0.0.64/26"]
      nsg_name = "Network_Monitoring_nsg"
    }
  }
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

# Settings for the public IP address to be used for egress
# Must be standard and static for Azure Firewall 
ip_addr_config = {
  ip_name           = "caf-pip-egress"
  allocation_method = "Static"
  #Dynamic Public IP Addresses aren't allocated until they're assigned to a resource (such as a Virtual Machine or a Load Balancer) by design within Azure 

  #properties below are optional 
  sku        = "Standard" #defaults to Basic
  ip_version = "IPv4"     #defaults to IP4, Only dynamic for IPv6, Supported arguments are IPv4 or IPv6, NOT Both
  #dns_prefix          = "arnaudmytest" 
  #timeout             = 15                                #TCP timeout for idle connections. The value can be set between 4 and 30 minutes.
  #zones               = [1]                               #1 zone number, IP address must be standard, ZoneRedundant argument is not supported in provider at time of writing
  #reverse_fqdn        = ""   
  #public_ip_prefix_id = "/subscriptions/00000000-00000-0000-0000-000000000000/resourceGroups/uqvh-hub-ingress-net/providers/Microsoft.Network/publicIPPrefixes/myprefix"
  #refer to the prefix and check sku types are same in IP and prefix 
  diagnostics = {
    log = [
      #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
      ["DDoSProtectionNotifications", true, true, 30],
      ["DDoSMitigationFlowLogs", true, true, 30],
      ["DDoSMitigationReports", true, true, 30],
    ]
    metric = [
      ["AllMetrics", true, true, 30],
    ]
  }
}

# Settings for the Azure Firewall settings
az_fw_config = {
  name = "az-fw-caf"
  diagnostics = {
    log = [
      #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
      ["AzureFirewallApplicationRule", true, true, 30],
      ["AzureFirewallNetworkRule", true, true, 30],
    ]
    metric = [
      ["AllMetrics", true, true, 30],
    ]
  }
}

# Settings for the UDR object
udr_object = {
  nexthop_type   = "VirtualAppliance"
  prefix         = "0.0.0.0/0"
  route_name     = "myWay"
  subnets_to_udr = ""
  nexthop_ip     = ""
}

# settings for the transit network blueprint 

#resource group creation
resource_groups_shared_transit = {
  HUB-NET-TRANSIT = {
    name     = "-hub-network-transit"
    location = "southeastasia"
  }
}

# Settings for the shared services egress vnet
networking_transit = {
  vnet = {
    name          = "Shared-Transit"
    address_space = ["172.16.0.0/23"]
    dns           = ["192.168.0.16", "192.168.0.64"]
  }
  specialsubnets = {
    GatewaySubnet = {
      name              = "GatewaySubnet" #Must be called GateWaySubnet in order to host a Virtual Network Gateway
      cidr              = ["172.16.0.0/24"]
      service_endpoints = []
    }
  }
  subnets = {
    subnet1 = {
      name              = "NetworkMonitoring"
      cidr              = ["172.16.1.0/24"]
      nsg_name          = "NetworkMonitoring_msg"
      service_endpoints = []
    }
  }
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

# Settings for the public IP address to be used for egress
public_ip_addr = {
  name              = "caf-pip-vpn"
  allocation_method = "Dynamic"
  sku               = "Basic"
  #For basic SKU, you can pick the zone to be deployed - if you want multi zone - pick Standard IP and pick AZ aware VPN gateway SKU
  #dns_prefix        = "arnaudvpn"
  #zones             = ["1"]
  diagnostics = {
    log = [
      #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
      ["DDoSProtectionNotifications", true, true, 30],
      ["DDoSMitigationFlowLogs", true, true, 30],
      ["DDoSMitigationReports", true, true, 30],
    ]
    metric = [
      ["AllMetrics", true, true, 30],
    ]
  }
}

# Settings for the Virtual Network gateway to be created
provision_gateway = false
gateway_config = {
  gateway_type = "VPN"
  # Possible values are "VPN" or "ExpressRoute"
  vpn_gateway_name = "mygateway"
  active_active    = false
  #An active-active gateway requires a HighPerformance or an UltraPerformance sku. If false, an active-standby gateway will be created. Defaults to false.
  enable_bgp = false
  #If true, BGP (Border Gateway Protocol) will be enabled for this Virtual Network Gateway. Defaults to false.
  vpn_gateway_sku = "Basic"
  #Valid options are Basic, Standard, HighPerformance, UltraPerformance, ErGw1AZ, ErGw2AZ, ErGw3AZ, VpnGw1, VpnGw2, VpnGw3, VpnGw1AZ, VpnGw2AZ, and VpnGw3AZ 
  #and depend on the gateway_type (ER or VPN) and vpn_type arguments, ie: PolicyBased gateway only supports the Basic sku.
  vpn_gateway_type = "RouteBased"
  #The routing type of the Virtual Network Gateway. Valid options are RouteBased or PolicyBased. Defaults to RouteBased.
  diagnostics = {
    log = [
      #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
      ["GatewayDiagnosticLog", true, true, 30],
      ["TunnelDiagnosticLog", true, true, 30],
      ["RouteDiagnosticLog", true, true, 30],
      ["IKEDiagnosticLog", true, true, 30],
      ["P2SDiagnosticLog", true, true, 30],
    ]
    metric = [
      ["AllMetrics", true, true, 30],
    ]
  }
}


#Settings for the connection to be established
#Settings for the local network connection 
connection_name        = "onpremconnection"
remote_network_connect = true

remote_network = {
  gateway_name         = "caf_local_network"
  gateway_ip           = "1.2.3.4"
  gateway_adress_space = ["1.0.0.0/8"]
}

##Settings for the Azure Key Vault

akv_config = {
  name = "techakv"
  akv_features = {
    enabled_for_disk_encryption     = true
    enabled_for_deployment          = true
    enabled_for_template_deployment = true
  }
  sku_name = "premium"
  # network_acls = {
  #     bypass = "AzureServices"
  #     default_action = "Deny"
  # }
  diagnostics = {
    log = [
      # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
      ["AuditEvent", true, true, 60],
    ]
    metric = [
      #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]                 
      ["AllMetrics", true, true, 60],
    ]
  }
}

# settings for the operations blueprint 

# #Azure Site Recovery Configuration
asr_config = {
  asr_vault_name = "asr"
  asr_diags = {
    log_analytics_destination_type = "Dedicated"
    log = [
      # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
      ["AzureBackupReport", true, true, 30],
      ["CoreAzureBackup", true, true, 30],
      ["AddonAzureBackupAlerts", true, true, 30],
      ["AddonAzureBackupJobs", true, true, 30],
      ["AddonAzureBackupPolicy", true, true, 30],
      ["AddonAzureBackupProtectedInstance", true, true, 30],
      ["AddonAzureBackupStorage", true, true, 30],
      ["AzureSiteRecoveryJobs", true, true, 30],
      ["AzureSiteRecoveryEvents", true, true, 30],
      ["AzureSiteRecoveryReplicatedItems", true, true, 30],
      ["AzureSiteRecoveryReplicationStats", true, true, 30],
      ["AzureSiteRecoveryRecoveryPoints", true, true, 30],
      ["AzureSiteRecoveryReplicationDataUploadRate", true, true, 30],
      ["AzureSiteRecoveryProtectedDiskDataChurn", true, true, 30],
    ]
    metric = [
      #["AllMetrics", 60, True],
    ]
  }
}


#Azure Automation account name
auto_config = {
  auto_account = "azauto"
  auto_diags = {
    log = [
      # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
      ["JobLogs", true, true, 30],
      ["JobStreams", true, true, 30],
      ["DscNodeStatus", true, true, 30],
    ]
    metric = [
      # ["Category name",  "Metric Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
      ["AllMetrics", true, true, 30],
    ]
  }
}
# Configuration sample for a hub and spoke environment
# definition of variables for the virtual network
rg_network = {
  CORE-NET = {
    name = "network-core"
  }
  TRANSIT-NET = {
    name = "network-transit"
  }
  EDGE-NET = {
    name = "network-edge"
  }
}

# settings for the core network blueprint 
core_networking = {
  shared_services_vnet = {
    vnet = {
      name          = "Core-Network"
      address_space = ["10.0.0.0/8"]
    }
    specialsubnets = {
      AzureFirewallSubnet = {
        name = "AzureFirewallSubnet" #Must be called AzureFirewallSubnet 
        cidr = "10.0.4.0/24"
      }
      GatewaySubnet = {
        name = "GatewaySubnet" #Must be called GateWaySubnet in order to host a Virtual Network Gateway
        cidr = "10.0.255.224/27"
      }
    }
    subnets = {
      subnet0 = {
        name = "Active_Directory"
        cidr = "10.0.1.0/24"
        nsg_inbound = [
          # {"Name", "Priority", "Direction", "Action", "Protocol", "source_port_range", "destination_port_range", "source_address_prefix", "destination_address_prefix" }, 
          ["W32Time", "100", "Inbound", "Allow", "udp", "*", "123", "*", "*"],
          ["RPC-Endpoint-Mapper", "101", "Inbound", "Allow", "tcp", "*", "135", "*", "*"],
          ["Kerberos-password-change", "102", "Inbound", "Allow", "*", "*", "464", "*", "*"],
          ["RPC-Dynamic-range", "103", "Inbound", "Allow", "tcp", "*", "49152-65535", "*", "*"],
          ["LDAP", "104", "Inbound", "Allow", "*", "*", "389", "*", "*"],
          ["LDAP-SSL", "105", "Inbound", "Allow", "tcp", "*", "636", "*", "*"],
          ["LDAP-GC", "106", "Inbound", "Allow", "tcp", "*", "3268", "*", "*"],
          ["LDAP-GC-SSL", "107", "Inbound", "Allow", "tcp", "*", "3269", "*", "*"],
          ["DNS", "108", "Inbound", "Allow", "*", "*", "53", "*", "*"],
          ["Kerberos", "109", "Inbound", "Allow", "*", "*", "88", "*", "*"],
          ["SMB", "110", "Inbound", "Allow", "tcp", "*", "445", "*", "*"],
        ]
      }
      subnet1 = {
        name = "AzureBastionSubnet" #Must be called AzureBastionSubnet 
        cidr = "10.0.0.128/25"
        nsg_inbound = [
          ["bastion-in-allow", "100", "Inbound", "Allow", "tcp", "*", "443", "*", "*"],
          ["bastion-control-in-allow-443", "120", "Inbound", "Allow", "tcp", "*", "443", "GatewayManager", "*"],
          ["bastion-control-in-allow-4443", "121", "Inbound", "Allow", "tcp", "*", "4443", "GatewayManager", "*"],
        ]
        nsg_outbound = [
          ["bastion-vnet-out-allow-22", "100", "Outbound", "Allow", "tcp", "*", "22", "*", "VirtualNetwork"],
          ["bastion-vnet-out-allow-3389", "101", "Outbound", "Allow", "tcp", "*", "3389", "*", "VirtualNetwork"],
          ["bastion-azure-out-allow", "120", "Outbound", "Allow", "tcp", "*", "443", "*", "AzureCloud"],
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

  # Settings for the public IP address to be used for Azure Firewall 
  # Must be standard and static for 
  firewall_ip_addr_config = {
    ip_name           = "firewall"
    allocation_method = "Static"
    sku               = "Standard" #defaults to Basic
    ip_version        = "IPv4"     #defaults to IP4, Only dynamic for IPv6, Supported arguments are IPv4 or IPv6, NOT Both
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
    name = "azfw"
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
  udr_web_to_az_firewall = {
    nexthop_type  = "VirtualAppliance"
    prefix        = "0.0.0.0/0"
    route_name    = "web_to_az_firewall"
    subnet_to_udr = "Web_tier"
    nexthop_ip    = ""
  }
  udr_transit_to_az_firewall = {
    nexthop_type  = "VirtualAppliance"
    prefix        = "10.0.1.0/24"
    route_name    = "transit_to_az_firewall"
    subnet_to_udr = "GatewaySubnet"
    nexthop_ip    = ""
  }

  ## DDoS standard configuration
  enable_ddos_standard = false
  ddos_name            = "ddos_protection_plan"

  ## settings for Azure bastion configuration
  ## not enabled, uncomment the code in the networking shared services blueprint.
  enable_bastion = false
  bastion_ip_addr_config = {
    ip_name = "bastion"
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
  }


  # Settings for the Virtual Network gateway to be created
  provision_gateway = false
  gateway_config = {
    gateway_type = "VPN"
    # Possible values are "VPN" or "ExpressRoute"
    vpn_gateway_name = "vpngateway"
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
    pip = {
      name              = "vpn"
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
  }

  #Settings for the connection to be established
  #Settings for the local network connection 
  connection_name        = "onpremconnection"
  remote_network_connect = true

  remote_network = {
    gateway_name         = "caf_local_network"
    gateway_ip           = "1.2.3.4"
    gateway_adress_space = ["1.0.0.0/8"]

    bgp_settings = {
      #     asn = 
      #     bgp_peering_address = 
      #     peer_weight = 
    }
  }

  ##Settings for the Azure Key Vault
  akv_config = {
    name = "vpn-akv"
    akv_features = {
      enabled_for_disk_encryption     = true
      enabled_for_deployment          = true
      enabled_for_template_deployment = true
    }
    sku_name = "standard"
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

}
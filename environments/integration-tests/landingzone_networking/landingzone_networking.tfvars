resource_groups = {
  vnet_us = {
    name       = "vnet-hub-us"
    location   = "westus2"
    useprefix  = true
    max_length = 40
  }
}

vnets = {
  hub_us = {
    resource_group_key = "vnet_us"
    location           = "westus2"
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

}

firewalls = {
  # Southeastasia firewall (do not change the key when created)
  westus2 = {
    location           = "westus2"
    resource_group_key = "vnet_us"
    vnet_key           = "hub_us"

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

  }

}
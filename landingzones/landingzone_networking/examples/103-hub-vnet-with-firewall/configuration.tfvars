resource_groups = {
  vnet_sg = {
    name       = "vnet-hub-sg"
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
  southeastasia = {
    location           = "southeastasia"
    resource_group_key = "vnet_sg"
    vnet_key           = "hub_sg"

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
      rules = {
        azurerm_firewall_network_rule_collection = {
          rule1 = {
            name     = "Authorize_http_https"
            action   = "Allow"
            priority = 105
            ruleset = [
              {
                name = "Authorize_http_https"
                source_addresses = [
                  "10.0.0.0/8",
                ]
                destination_ports = [
                  "80", "443",
                ]
                destination_addresses = [
                  "*"
                ]
                protocols = [
                  "TCP",
                ]
              },
              {
                name = "Authorize_kerberos"
                source_addresses = [
                  "10.0.0.0/8",
                ]
                destination_ports = [
                  "88",
                ]
                destination_addresses = [
                  "*"
                ]
                protocols = [
                  "TCP", "UDP",
                ]
              }
            ]
          }
        }
      }
    }

  }

}
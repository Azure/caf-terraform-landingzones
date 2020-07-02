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

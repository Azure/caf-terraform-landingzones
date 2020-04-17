# settings for the shared egress blueprint 
resource_groups_shared_egress = {
    HUB-EGRESS-NET    = {
        name = "-hub-network-egress"
        location = "southeastasia"
    }
}

# Settings for the shared services egress vnet - note that Azure Firewall subnet must be at least /26 
networking_egress = {
    vnet = {
        name                = "Shared-Egress"
        address_space       = ["10.0.0.0/25"]     
        dns                 = ["192.168.0.16", "192.168.0.64"]
    }
    specialsubnets     = {
        AzureFirewallSubnet     = {
            name                = "AzureFirewallSubnet"
            cidr                = "10.0.0.0/26"
            service_endpoints   = []
        }
        }
    subnets = {
        subnet1                 = {
            name                = "Network_Monitoring"
            cidr                = "10.0.0.64/26"
            service_endpoints   = []
            nsg_inbound         = []
            nsg_outbound        = []
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
    ip_name = "caf-pip-egress"    
    allocation_method   = "Static"
    #Dynamic Public IP Addresses aren't allocated until they're assigned to a resource (such as a Virtual Machine or a Load Balancer) by design within Azure 
    
    #properties below are optional 
    sku                 = "Standard"                        #defaults to Basic
    ip_version          = "IPv4"                            #defaults to IP4, Only dynamic for IPv6, Supported arguments are IPv4 or IPv6, NOT Both
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
    nexthop_type = "VirtualAppliance"
    prefix = "0.0.0.0/0"
    route_name = "myWay"
    subnets_to_udr = ""
    nexthop_ip = ""
}
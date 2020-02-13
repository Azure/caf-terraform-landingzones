# settings for the shared network blueprint 
resource_groups_shared_services = {
    HUB-CORE-NET    = {
        name = "-hub-network-shared"  
        location = "southeastasia"  
    }
}

enable_ddos_standard = false
ddos_name            = "ddos_protection_plan"

shared_services_vnet = {
        vnet = {
            name                = "Shared-Services"
            address_space       = ["10.101.4.0/22"]
            dns                 = []
        }
        specialsubnets     = {
                            }
        subnets = {
            subnet0                 = {
                name                = "Critical_Applications"
                cidr                = "10.101.4.0/25"
                service_endpoints   = []
                nsg_inbound         = []
                nsg_outbound        = []
            }
            subnet1                 = {
                name                = "Active_Directory"
                cidr                = "10.101.4.128/27"
                service_endpoints   = []
                nsg_inbound         = [
                    # {"Name", "Priority", "Direction", "Action", "Protocol", "source_port_range", "destination_port_range", "source_address_prefix", "destination_address_prefix" }, 
                    ["LDAP", "100", "Inbound", "Allow", "*", "*", "389", "*", "*"],
                    ["RPC-EPM", "102", "Inbound", "Allow", "tcp", "*", "135", "*", "*"],
                    ["SMB-In", "103", "Inbound", "Allow", "tcp", "*", "445", "*", "*"],
                ]
                nsg_outbound        = [
                    ["o-LDAP-t", "100", "Outbound", "Allow", "*", "*", "389", "*", "*"],
                    ["o-SMB-In", "103", "Outbound", "Allow", "tcp", "*", "445", "*", "*"],
                ]
            }
            subnet2                 = {
                name                = "SQL_Servers"
                cidr                = "10.101.4.160/27"
                service_endpoints   = []
                nsg_inbound         = [
                    # {"Name", "Priority", "Direction", "Action", "Protocol", "source_port_range", "destination_port_range", "source_address_prefix", "destination_address_prefix" }, 
                    ["TDS-In", "100", "Inbound", "Allow", "tcp", "*", "1433", "*", "*"],
                ]
                nsg_outbound        = []
            }
            subnet4                 = {
                name                = "AzureBastionSubnet"
                cidr                = "10.101.4.192/27"
                service_endpoints   = []
                nsg_inbound         = [
                    ["bastion-in-allow", "100", "Inbound", "Allow", "tcp", "*", "443", "*", "*"],
                    ["bastion-control-in-allow-443", "120", "Inbound", "Allow", "tcp", "*", "443", "GatewayManager", "*"],
                    ["bastion-control-in-allow-4443", "121", "Inbound", "Allow", "tcp", "*", "4443", "GatewayManager", "*"],
                ]
                nsg_outbound        = [
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

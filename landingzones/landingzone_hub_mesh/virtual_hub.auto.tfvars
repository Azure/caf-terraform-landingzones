# settings for the shared network blueprint 
resource_groups_virtual_hubs = {
    hub1  = {
        name = "-virtualhub"
    }
}

virtual_hub_config = {
    virtual_wan = {
        name        = "ContosovWAN"
        dns_name = "private.contoso.com"
        
        hub1 = {
            hub_name    = "SEA-HUB"
            region     = "southeastasia"
            hub_address_prefix = "10.0.1.0/24"
            firewall_name = "azfwvhub-sea"
            list_of_vnets_to_peer = []

            deploy_p2s = false
            p2s_config = {}
            deploy_s2s = true
            s2s_config = {
                scale_unit = 1
            }
            deploy_er  = false
            er_config = {} 
        }
        hub2 = {
            hub_name    = "DUB-HUB"
            region     = "northeurope"
            hub_address_prefix = "10.0.2.0/24"
            firewall_name = "azfwvhub-dub"
            list_of_vnets_to_peer = []

            deploy_p2s = false
            p2s_config = {}
            deploy_s2s = false
            s2s_config = {}
            deploy_er  = false
            er_config = {} 
        }
    }

    shared_services_vnet = {
        vnet = {
            name                = "Core-Network"
            address_space       = ["10.0.0.0/8"]
        }
        specialsubnets     = {
            AzureFirewallSubnet = {
            name                = "AzureFirewallSubnet" #Must be called AzureFirewallSubnet 
            cidr                = "10.0.4.0/24"
            }
            GatewaySubnet = {
            name                = "GatewaySubnet" #Must be called GateWaySubnet in order to host a Virtual Network Gateway
            cidr                = "10.0.255.224/27"
            }
        }
        subnets = {
            subnet0                 = {
                name                = "Web_tier"
                cidr                = "10.0.1.0/24"
                nsg_inbound         = [
                    # {"Name", "Priority", "Direction", "Action", "Protocol", "source_port_range", "destination_port_range", "source_address_prefix", "destination_address_prefix" }, 
                    ["HTTP-In", "100", "Inbound", "Allow", "tcp", "*", "80", "*", "*"],
                    ["HTTPS-In", "101", "Inbound", "Allow", "tcp", "*", "443", "*", "*"],
                ]
            }
            subnet1                 = {
                name                = "Business_tier"
                cidr                = "10.0.2.0/24"
                nsg_inbound         = [
                    # {"Name", "Priority", "Direction", "Action", "Protocol", "source_port_range", "destination_port_range", "source_address_prefix", "destination_address_prefix" }, 
                    ["HTTP-In", "100", "Inbound", "Allow", "tcp", "*", "80", "*", "*"],
                    ["HTTPS-In", "101", "Inbound", "Allow", "tcp", "*", "443", "*", "*"],
                ]
                nsg_outbound        = [
                    ["HTTP-Out", "100", "Outbound", "Allow", "tcp", "*", "80", "*", "*"],
                    ["HTTPS-Out", "101", "Outbound", "Allow", "tcp", "*", "443", "*", "*"],
                ]
            }
            subnet2                 = {
                name                = "Data_tier"
                cidr                = "10.0.3.0/24"
                nsg_inbound         = [
                    # {"Name", "Priority", "Direction", "Action", "Protocol", "source_port_range", "destination_port_range", "source_address_prefix", "destination_address_prefix" }, 
                    ["TDS-In", "100", "Inbound", "Allow", "tcp", "*", "1433", "*", "*"],
                ]
            }
            subnet3                 = {
                name                = "AzureBastionSubnet" #Must be called AzureBastionSubnet 
                cidr                = "10.0.0.128/25"
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

# Settings for the public IP address to be used for Azure Firewall 
# Must be standard and static for 
    ip_addr_config = {
        ip_name = "firewall"    
        allocation_method   = "Static"
        sku                 = "Standard"                        #defaults to Basic
        ip_version          = "IPv4"                            #defaults to IP4, Only dynamic for IPv6, Supported arguments are IPv4 or IPv6, NOT Both
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


    # ## settings for Azure bastion configuration
    # ## not enabled, uncomment the code in the networking shared services blueprint.
    # enable_bastion = false

    # bastion_config = {
    #     name = "azurebastion"
    #     diagnostics = {
    #         log = [
    #             #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
    #             ["BastionAuditLogs", true, true, 30],
    #         ]
    #         metric = [
    #             #    ["AllMetrics", true, true, 30],
    #         ]
    #     }
    #     ip_name = "caf-pip-bastion"
    #     ip_addr = {
    #             allocation_method   = "Static"
    #             #Dynamic Public IP Addresses aren't allocated until they're assigned to a resource (such as a Virtual Machine or a Load Balancer) by design within Azure 
                
    #             #properties below are optional 
    #             sku                 = "Standard"                        #defaults to Basic
    #             ip_version          = "IPv4"                            #defaults to IP4, Only dynamic for IPv6, Supported arguments are IPv4 or IPv6, NOT Both
    #             #dns_prefix          = "arnaudmytest" 
    #             #timeout             = 15                                #TCP timeout for idle connections. The value can be set between 4 and 30 minutes.
    #             #zones               = [1]                               #1 zone number, IP address must be standard, ZoneRedundant argument is not supported in provider at time of writing
    #             #reverse_fqdn        = ""   
    #             #public_ip_prefix_id = "/subscriptions/00000000-00000-0000-0000-000000000000/resourceGroups/uqvh-hub-ingress-net/providers/Microsoft.Network/publicIPPrefixes/myprefix"
    #             #refer to the prefix and check sku types are same in IP and prefix 
    #     }
    #     ip_diags = {
    #         log = [
    #                     #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
    #                     ["DDoSProtectionNotifications", true, true, 30],
    #                     ["DDoSMitigationFlowLogs", true, true, 30],
    #                     ["DDoSMitigationReports", true, true, 30],
    #             ]
    #         metric = [
    #                 ["AllMetrics", true, true, 30],
    #         ]
    #     }
}
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
            name                = "_Shared_Services"
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
                    ["LDAP-t", "100", "Inbound", "Allow", "*", "*", "389", "*", "*"],
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
            subnet3                 = {
                name                = "Network_Monitoring"
                cidr                = "10.101.4.192/27"
                service_endpoints   = []
                nsg_inbound         = []
                nsg_outbound        = []
            }
        }
}
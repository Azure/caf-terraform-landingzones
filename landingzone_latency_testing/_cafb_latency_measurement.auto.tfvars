latency_measurement_resource_groups = {
    rg1 = {
        name        = "rg-latency-singapore"
        location    = "southeastasia"
        tags        = {
            "RTO" = "1h"
        }
    }
    rg2 = {
        name        = "rg-latency-africa"
        location    = "southafricanorth"
    }
}


latency_measurement_networking = {
    region1 = {
        location                = "southeastasia"
        vnet = {
            name                = "vnet-singapore"
            address_space       = ["10.0.0.0/24"]     
            dns                 = []
        }
        specialsubnets     = { }
        subnets = {
            subnet1                 = {
                name                = "vm"
                cidr                = "10.0.0.0/25"
                service_endpoints   = []
                nsg_inbound         = []
                nsg_outbound        = []
            }
        }
    }
    region2 = {
        location                = "southafricanorth"
        vnet = {
            name                = "vnet-africa"
            address_space       = ["10.0.1.0/24"]     
            dns                 = []
        }
        specialsubnets     = { }
        subnets = {
            subnet1                 = {
                name                = "vm"
                cidr                = "10.0.1.0/25"
                service_endpoints   = []
                nsg_inbound         = []
                nsg_outbound        = []
            }
        }
    }
}

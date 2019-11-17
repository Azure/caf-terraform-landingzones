
module "blueprint_networking_shared_egress" {
    source = "./blueprint_networking_shared_egress"
  
    prefix                              = module.blueprint_tranquility.prefix
    location                            = module.blueprint_tranquility.location_map
    log_analytics_workspace             = module.blueprint_tranquility.log_analytics_workspace
    diagnostics_map                     = module.blueprint_tranquility.diagnostics_map
    tags                                = module.blueprint_tranquility.tags
    
    resource_groups_shared_egress       = var.resource_groups_shared_egress

    networking_object                   = var.networking_egress
    ip_name                             = var.ip_name
    ip_addr                             = var.ip_addr
    az_fw_name                          = var.az_fw_name
    udr_prefix                          = var.udr_prefix
    udr_nexthop_type                    = var.udr_nexthop_type
    udr_nexthop_ip                      = var.udr_nexthop_ip
    udr_route_name                      = var.udr_route_name
    subnets_to_udr                      = var.subnets_to_udr
    
    fw_diags                            = var.az_fw_diags
    ip_diags                            = var.ip_addr_diags

    shared_services_vnet_object         = module.blueprint_networking_shared_services.shared_services_vnet_object
    virtual_network_rg                  = module.blueprint_networking_shared_services.resource_group_shared_services
}

module "blueprint_networking_shared_egress" {
    source = "./blueprint_networking_shared_egress"
  
    prefix                              = module.blueprint_foundations.prefix
    location                            = var.location_map["region1"]
    log_analytics_workspace             = module.blueprint_foundations.log_analytics_workspace
    diagnostics_map                     = module.blueprint_foundations.diagnostics_map
    tags                                = module.blueprint_foundations.tags
    
    resource_groups_shared_egress       = var.resource_groups_shared_egress

    networking_object                   = var.networking_egress
    ip_addr_config                      = var.ip_addr_config
    az_fw_config                        = var.az_fw_config
    udr_object                          = var.udr_object
    
    shared_services_vnet_object         = module.blueprint_networking_shared_services.shared_services_vnet_object
    virtual_network_rg                  = module.blueprint_networking_shared_services.resource_group_shared_services
}
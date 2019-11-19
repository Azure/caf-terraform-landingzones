module "blueprint_networking_shared_services" {
    source = "./blueprint_networking_shared_services"
  
    prefix                              = module.blueprint_tranquility.prefix
    location                            = module.blueprint_tranquility.location_map["region1"]
    log_analytics_workspace             = module.blueprint_tranquility.log_analytics_workspace
    diagnostics_map                     = module.blueprint_tranquility.diagnostics_map
    tags                                = module.blueprint_tranquility.tags
    
    virtual_network_rg                  = var.resource_groups_shared_services["HUB-CORE-NET"]
    resource_groups_shared_services     = var.resource_groups_shared_services
    shared_services_vnet                = var.shared_services_vnet
     
    ddos_name                           = var.ddos_name
    enable_ddos_standard                = var.enable_ddos_standard
}

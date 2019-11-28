module "blueprint_networking_shared_services" {
    source = "./blueprint_networking_shared_services"
  
    prefix                              = module.blueprint_foundations.prefix
    location                            = var.location_map["region1"]
    log_analytics_workspace             = module.blueprint_foundations.log_analytics_workspace
    diagnostics_map                     = module.blueprint_foundations.diagnostics_map
    tags                                = module.blueprint_foundations.tags
    
    virtual_network_rg                  = var.resource_groups_shared_services["HUB-CORE-NET"]
    resource_groups_shared_services     = var.resource_groups_shared_services
    shared_services_vnet                = var.shared_services_vnet
     
    ddos_name                           = var.ddos_name
    enable_ddos_standard                = var.enable_ddos_standard
    enable_bastion                      = var.enable_bastion
    bastion_config                      = var.bastion_config
}

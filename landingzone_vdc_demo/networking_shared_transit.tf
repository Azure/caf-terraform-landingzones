module "blueprint_networking_shared_transit" {
    source = "./blueprint_networking_shared_transit"
  
    prefix                              = module.blueprint_foundations.prefix
    log_analytics_workspace             = module.blueprint_foundations.log_analytics_workspace
    diagnostics_map                     = module.blueprint_foundations.diagnostics_map
    tags                                = module.blueprint_foundations.tags

    location                            = var.location_map["region1"]
    ip_addr_config                      = var.public_ip_addr
    remote_network                      = var.remote_network
    connection_name                     = var.connection_name
    resource_groups_shared_transit      = var.resource_groups_shared_transit
    networking_object                   = var.networking_transit
    networking_transit                  = var.networking_transit
    remote_network_connect              = var.remote_network_connect
    gateway_config                      = var.gateway_config
    provision_gateway                   = var.provision_gateway
    

    shared_services_vnet_object         = module.blueprint_networking_shared_services.shared_services_vnet_object
    virtual_network_rg                  = module.blueprint_networking_shared_services.resource_group_shared_services

    akv_config                          = var.akv_config
}

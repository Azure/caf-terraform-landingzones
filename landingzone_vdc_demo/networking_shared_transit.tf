module "blueprint_networking_shared_transit" {
    source = "./blueprint_networking_shared_transit"
  
    prefix                              = module.blueprint_tranquility.prefix
    location                            = module.blueprint_tranquility.location_map
    log_analytics_workspace             = module.blueprint_tranquility.log_analytics_workspace
    diagnostics_map                     = module.blueprint_tranquility.diagnostics_map
    tags                                = module.blueprint_tranquility.tags

    ip_name                             = var.ip_address_name
    ip_addr                             = var.public_ip_addr
    remote_network                      = var.remote_network
    connection_name                     = var.connection_name
    resource_groups_shared_transit      = var.resource_groups_shared_transit
    networking_object                   = var.networking_transit
    networking_transit                  = var.networking_transit
    remote_network_connect              = var.remote_network_connect
    gateway_config                      = var.gateway_config

    ip_diags                            = var.ip_diags
    gateway_diags                       = var.gateway_diags

    shared_services_vnet_object         = module.blueprint_networking_shared_services.shared_services_vnet_object
    virtual_network_rg                  = module.blueprint_networking_shared_services.resource_group_shared_services
}

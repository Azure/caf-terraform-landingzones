module "blueprint_networking_shared_services" {
    source = "./blueprint_networking_shared_services"
  
    global_settings                     = local.global_settings
    prefix                              = local.prefix
    location                            = local.global_settings.location_map["region1"]
    log_analytics_workspace             = local.caf_foundations_accounting.log_analytics_workspace
    diagnostics_map                     = local.caf_foundations_accounting.diagnostics_map
    tags                                = local.global_settings.tags_hub
    
    virtual_network_rg                  = var.resource_groups_shared_services["HUB-CORE-NET"]
    resource_groups_shared_services     = var.resource_groups_shared_services
    shared_services_vnet                = var.shared_services_vnet
     
    ddos_name                           = var.ddos_name
    enable_ddos_standard                = var.enable_ddos_standard
    enable_bastion                      = var.enable_bastion
    bastion_config                      = var.bastion_config
}

module "blueprint_networking_shared_egress" {
    source = "./blueprint_networking_shared_egress"
  
    global_settings                     = local.global_settings
    prefix                              = local.prefix
    location                            = local.global_settings.location_map["region1"]
    log_analytics_workspace             = local.caf_foundations_accounting.log_analytics_workspace
    diagnostics_map                     = local.caf_foundations_accounting.diagnostics_map
    tags                                = local.global_settings.tags_hub
    
    resource_groups_shared_egress       = var.resource_groups_shared_egress
    networking_object                   = var.networking_egress
    ip_addr_config                      = var.ip_addr_config
    az_fw_config                        = var.az_fw_config
    udr_object                          = var.udr_object
    
    shared_services_vnet_object         = module.blueprint_networking_shared_services.shared_services_vnet_object
    virtual_network_rg                  = module.blueprint_networking_shared_services.resource_group_shared_services
}

module "blueprint_networking_shared_transit" {
    source = "./blueprint_networking_shared_transit"
  
    global_settings                     = local.global_settings
    prefix                              = local.prefix
    location                            = local.global_settings.location_map["region1"]
    log_analytics_workspace             = local.caf_foundations_accounting.log_analytics_workspace
    diagnostics_map                     = local.caf_foundations_accounting.diagnostics_map
    tags                                = local.global_settings.tags_hub

    ip_addr_config                      = var.public_ip_addr
    remote_network                      = var.remote_network
    connection_name                     = var.connection_name
    resource_groups_shared_transit      = var.resource_groups_shared_transit
    networking_object                   = var.networking_transit
    networking_transit                  = var.networking_transit
    remote_network_connect              = var.remote_network_connect
    gateway_config                      = var.gateway_config
    provision_gateway                   = var.provision_gateway
    akv_config                          = var.akv_config
    logged_user_objectId                = var.logged_user_objectId
    
    shared_services_vnet_object         = module.blueprint_networking_shared_services.shared_services_vnet_object
    virtual_network_rg                  = module.blueprint_networking_shared_services.resource_group_shared_services
}

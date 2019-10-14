
module "resource_group_shared_transit" {
  source  = "aztfmod/caf-resource-group/azurerm"
  version = "0.1.1"

  prefix          = var.prefix
  resource_groups = var.resource_groups_shared_transit
  tags            = local.tags
}

module "networking_transit_vnet" {
  source  = "aztfmod/caf-virtual-network/azurerm"
  version = "0.1.0"

  virtual_network_rg                = module.resource_group_shared_transit.names["HUB-NET-TRANSIT"]
  prefix                            = var.prefix
  location                          = var.location["region1"]
  networking_object                 = var.networking_object
  tags                              = local.tags
  diagnostics_map                   = var.diagnostics_map
  log_analytics_workspace           = var.log_analytics_workspace
}

module "networking_transit_public_ip" {
  source  = "aztfmod/caf-public-ip/azurerm"
  version = "0.1.2"

  name                             = var.ip_name
  location                         = var.location["region1"]
  rg                               = module.resource_group_shared_transit.names["HUB-NET-TRANSIT"]
  ip_addr                          = var.ip_addr
  tags                             = local.tags
  diagnostics_map                  = var.diagnostics_map
  log_analytics_workspace_id       = var.log_analytics_workspace.id
  diagnostics_settings             = var.ip_diags
}

module "vpn_gateway" {
  source = "./vpn_gateway"
  
  location                            = var.location["region1"]
  resource_group_name                 = module.resource_group_shared_transit.names["HUB-NET-TRANSIT"]
  tags                                = local.tags
  gateway_config                      = var.gateway_config
  remote_network                      = var.remote_network
  remote_network_connect              = var.remote_network_connect
  connection_name                     = var.connection_name
  public_ip_addr                      = module.networking_transit_public_ip.id
  gateway_subnet                      = module.networking_transit_vnet.vnet_subnets["GatewaySubnet"]
  diagnostics_map                     = var.diagnostics_map
  log_analytics_workspace             = var.log_analytics_workspace
  gateway_diags                       = var.gateway_diags
}


#enable network peering with hub shared network

resource "azurerm_virtual_network_peering" "peering_shared_services_to_transit" {
  depends_on                    = [ module.networking_transit_vnet ]

  name                          = "shared_services_to_transit"
  resource_group_name           = var.virtual_network_rg.names["HUB-CORE-NET"]
  virtual_network_name          = var.shared_services_vnet_object.vnet_name
  remote_virtual_network_id     = module.networking_transit_vnet.vnet_obj.id
  allow_virtual_network_access  = true
  allow_forwarded_traffic       = true
  allow_gateway_transit = true
}

resource "azurerm_virtual_network_peering" "peering_transit_to_shared_services" {
  depends_on                    = [ module.networking_transit_vnet ]
  
  name                          = "transit_to_shared_services"
  resource_group_name           = module.resource_group_shared_transit.names["HUB-NET-TRANSIT"]
  virtual_network_name          = module.networking_transit_vnet.vnet_obj.name
  remote_virtual_network_id     = var.shared_services_vnet_object.vnet_id
  allow_virtual_network_access  = true
  allow_forwarded_traffic       = true
}
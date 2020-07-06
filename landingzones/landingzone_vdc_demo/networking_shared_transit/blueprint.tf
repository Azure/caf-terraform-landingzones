resource "azurecaf_naming_convention" "rg_network_transit" {
  name          = var.resource_groups_shared_transit.HUB-NET-TRANSIT.name
  prefix        = var.prefix != "" ? var.prefix : null
  resource_type = "azurerm_resource_group"
  convention    = var.global_settings.convention
}

resource "azurerm_resource_group" "rg_network_transit" {
  name     = azurecaf_naming_convention.rg_network_transit.result
  location = var.resource_groups_shared_transit.HUB-NET-TRANSIT.location
  tags     = local.tags
}

module "networking_transit_vnet" {
  source = "github.com/aztfmod/terraform-azurerm-caf-virtual-network?ref=vnext"
  # source  = "aztfmod/caf-virtual-network/azurerm"
  # version = "3.0.0"

  convention              = var.global_settings.convention
  resource_group_name     = azurerm_resource_group.rg_network_transit.name
  prefix                  = var.prefix
  location                = var.location
  networking_object       = var.networking_object
  tags                    = local.tags
  diagnostics_map         = var.diagnostics_map
  log_analytics_workspace = var.log_analytics_workspace
  diagnostics_settings    = var.networking_object.diagnostics
}

module "networking_transit_public_ip" {
  source = "github.com/aztfmod/terraform-azurerm-caf-public-ip?ref=vnext"
  # source  = "aztfmod/caf-public-ip/azurerm"
  # version = "2.0.0"

  convention                 = var.global_settings.convention
  name                       = var.ip_addr_config.name
  location                   = var.location
  resource_group_name        = azurerm_resource_group.rg_network_transit.name
  ip_addr                    = var.ip_addr_config
  tags                       = local.tags
  diagnostics_map            = var.diagnostics_map
  log_analytics_workspace_id = var.log_analytics_workspace.id
  diagnostics_settings       = var.ip_addr_config.diagnostics
}

module "vpn_gateway" {
  source = "./vpn_gateway"

  provision_gateway       = var.provision_gateway
  location                = var.location
  resource_group_name     = azurerm_resource_group.rg_network_transit.name
  tags                    = local.tags
  gateway_config          = var.gateway_config
  remote_network          = var.remote_network
  remote_network_connect  = var.remote_network_connect
  connection_name         = var.connection_name
  public_ip_addr          = module.networking_transit_public_ip.id
  gateway_subnet          = module.networking_transit_vnet.vnet_subnets["GatewaySubnet"]
  diagnostics_map         = var.diagnostics_map
  log_analytics_workspace = var.log_analytics_workspace
  diagnostics_settings    = var.gateway_config.diagnostics
  keyvaultid              = module.keyvault.id
  logged_user_objectId    = var.logged_user_objectId
}

module "keyvault" {
  source = "github.com/aztfmod/terraform-azurerm-caf-keyvault?ref=vnext"
  # source  = "aztfmod/caf-keyvault/azurerm"
  # version = "2.0.0"

  convention              = var.global_settings.convention
  resource_group_name     = azurerm_resource_group.rg_network_transit.name
  akv_config              = var.akv_config
  prefix                  = var.prefix
  location                = var.location
  tags                    = local.tags
  log_analytics_workspace = var.log_analytics_workspace
  diagnostics_settings    = var.akv_config.diagnostics
  diagnostics_map         = var.diagnostics_map
}

#enable network peering with hub shared network
resource "azurerm_virtual_network_peering" "peering_shared_services_to_transit" {
  depends_on = [module.networking_transit_vnet]

  name                         = "shared_services_to_transit"
  resource_group_name          = var.virtual_network_rg.name
  virtual_network_name         = var.shared_services_vnet_object.vnet_name
  remote_virtual_network_id    = module.networking_transit_vnet.vnet_obj.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
}

resource "azurerm_virtual_network_peering" "peering_transit_to_shared_services" {
  depends_on = [module.networking_transit_vnet]

  name                         = "transit_to_shared_services"
  resource_group_name          = azurerm_resource_group.rg_network_transit.name
  virtual_network_name         = module.networking_transit_vnet.vnet_obj.name
  remote_virtual_network_id    = var.shared_services_vnet_object.vnet_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}
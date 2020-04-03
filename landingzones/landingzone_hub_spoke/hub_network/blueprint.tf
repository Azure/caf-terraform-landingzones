resource "azurecaf_naming_convention" "rg_network_name" {  
  name             = var.rg_network.CORE-NET.name
  prefix           = var.prefix != "" ? var.prefix : null
  resource_type    = "azurerm_resource_group"
  convention       = var.global_settings.convention
}

resource "azurecaf_naming_convention" "rg_transit_name" {  
  name             = var.rg_network.TRANSIT-NET.name
  prefix           = var.prefix != "" ? var.prefix : null
  resource_type    = "azurerm_resource_group"
  convention       = var.global_settings.convention
}

resource "azurecaf_naming_convention" "rg_edge_name" {  
  name             = var.rg_network.EDGE-NET.name
  prefix           = var.prefix != "" ? var.prefix : null
  resource_type    = "azurerm_resource_group"
  convention       = var.global_settings.convention
}

resource "azurerm_resource_group" "rg_network" {
  name     = azurecaf_naming_convention.rg_network_name.result
  location = var.global_settings.location_map.region1
  tags     = var.global_settings.tags_hub
}

resource "azurerm_resource_group" "rg_transit" {
  name     = azurecaf_naming_convention.rg_transit_name.result
  location = var.global_settings.location_map.region1
  tags     = var.global_settings.tags_hub
}

resource "azurerm_resource_group" "rg_edge" {
  name     = azurecaf_naming_convention.rg_edge_name.result
  location = var.global_settings.location_map.region1
  tags     = var.global_settings.tags_hub
}


## Shared service virtual network
module "core_network" {
  source  = "aztfmod/caf-virtual-network/azurerm"
  version = "2.0.0"

  convention                        = var.global_settings.convention
  resource_group_name               = azurerm_resource_group.rg_network.name
  prefix                            = var.prefix
  location                          = var.global_settings.location_map.region1
  networking_object                 = var.core_networking.shared_services_vnet
  tags                              = var.global_settings.tags_hub
  diagnostics_map                   = var.caf_foundations_accounting.diagnostics_map
  log_analytics_workspace           = var.caf_foundations_accounting.log_analytics_workspace
  diagnostics_settings              = var.core_networking.shared_services_vnet.diagnostics
  ddos_id                           = var.core_networking.enable_ddos_standard ? module.ddos_protection_std.id : ""
}


## Azure Firewall configuration
module "az_firewall_ip" {
  source  = "aztfmod/caf-public-ip/azurerm"
  version = "2.0.0"

  convention                       = var.global_settings.convention 
  name                             = var.core_networking.ip_addr_config.ip_name
  location                         = var.location
  resource_group_name              = azurerm_resource_group.rg_edge.name
  ip_addr                          = var.core_networking.ip_addr_config
  tags                             = var.global_settings.tags_hub
  diagnostics_map                  = var.caf_foundations_accounting.diagnostics_map
  log_analytics_workspace_id       = var.caf_foundations_accounting.log_analytics_workspace.id
  diagnostics_settings             = var.core_networking.ip_addr_config.diagnostics
}

module "az_firewall" {
  source  = "aztfmod/caf-azure-firewall/azurerm"
  version = "2.0.0"

  convention                        = var.global_settings.convention 
  name                              = var.core_networking.az_fw_config.name
  resource_group_name               = azurerm_resource_group.rg_network.name
  subnet_id                         = lookup(module.core_network.vnet_subnets, "AzureFirewallSubnet", null)
  public_ip_id                      = module.az_firewall_ip.id
  location                          = var.global_settings.location_map.region1
  tags                              = var.global_settings.tags_hub
  diagnostics_map                   = var.caf_foundations_accounting.diagnostics_map
  la_workspace_id                   = var.caf_foundations_accounting.log_analytics_workspace.id
  diagnostics_settings              = var.core_networking.az_fw_config.diagnostics
}

module "firewall_dashboard" {
  source = "./firewall_dashboard"

  fw_id       = module.az_firewall.id
  pip_id      = module.az_firewall_ip.id
  location    = var.location
  rg          = azurerm_resource_group.rg_network.name
  name        = basename(abspath(path.module))
  tags        = var.global_settings.tags_hub
}

module "firewall_rules" {
  source = "./firewall_rules"
  
  az_firewall_settings              = module.az_firewall.az_firewall_config
}

# Azure DDoS protection configuration
module "ddos_protection_std" {
  source = "./ddos_protection"

  enable_ddos_standard              = var.core_networking.enable_ddos_standard
  name                              = var.core_networking.ddos_name
  rg                                = azurerm_resource_group.rg_edge.name
  location                          = var.location
  tags                              = var.global_settings.tags_hub
}

# Azure Bastion Configuration
# Please check Azure Bastion availability in the target region: https://azure.microsoft.com/en-us/global-infrastructure/services/?products=azure-bastion 
module "bastion_host" {
  source = "./bastion"

  enable_bastion                    = var.core_networking.enable_bastion
  name                              = var.core_networking.bastion_config.name
  rg                                = azurerm_resource_group.rg_edge.name
  subnet_id                         = lookup(module.core_network.vnet_subnets, "AzureBastionSubnet", null)
  location                          = var.location 
  tags                              = local.tags
  caf_foundations_accounting        = var.caf_foundations_accounting
  bastion_config                    = var.core_networking.bastion_config
  global_settings                   = var.global_settings
}


## Azure Site-to-Site Gateway
# public IP address for VPN gateway
module "vpn_pip" {
  source  = "aztfmod/caf-public-ip/azurerm"
  version = "2.0.0"

  convention                       = var.global_settings.convention 
  name                             = var.core_networking.gateway_config.pip.name
  location                         = var.location
  resource_group_name              = azurerm_resource_group.rg_transit.name
  ip_addr                          = var.core_networking.gateway_config.pip
  tags                             = var.global_settings.tags_hub
  diagnostics_map                  = var.caf_foundations_accounting.diagnostics_map
  log_analytics_workspace_id       = var.caf_foundations_accounting.log_analytics_workspace.id
  diagnostics_settings             = var.core_networking.gateway_config.pip.diagnostics
}

# VPN gateway is deployed only if var.core_networking.provision_gateway is set to true
module "vpn_gateway" {
  source = "./vpn_gateway"
  
  provision_gateway                   = var.core_networking.provision_gateway
  location                            = var.location
  resource_group_name                 = azurerm_resource_group.rg_transit.name
  tags                                = local.tags
  gateway_config                      = var.core_networking.gateway_config
  remote_network                      = var.core_networking.remote_network
  remote_network_connect              = var.core_networking.remote_network_connect
  connection_name                     = var.core_networking.connection_name
  public_ip_addr                      = module.vpn_pip.id
  gateway_subnet                      = lookup(module.core_network.vnet_subnets, "GatewaySubnet", null)
  diagnostics_map                     = var.core_networking.gateway_config.diagnostics
  caf_foundations_accounting          = var.caf_foundations_accounting
  keyvaultid                          = module.keyvault_vpn.id
  logged_user_objectId              = var.logged_user_objectId
}

# deploying a Keyvault to store the PSK of the S2S VPN
module "keyvault_vpn" {
  source  = "aztfmod/caf-keyvault/azurerm"
  version = "2.0.0"
  
  convention                        = var.global_settings.convention 
  resource_group_name               = azurerm_resource_group.rg_transit.name
  akv_config                        = var.core_networking.akv_config
  prefix                            = var.prefix
  location                          = var.location
  tags                              = local.tags
  log_analytics_workspace           = var.caf_foundations_accounting.log_analytics_workspace
  diagnostics_settings              = var.core_networking.akv_config.diagnostics
  diagnostics_map                   = var.caf_foundations_accounting.diagnostics_map
}
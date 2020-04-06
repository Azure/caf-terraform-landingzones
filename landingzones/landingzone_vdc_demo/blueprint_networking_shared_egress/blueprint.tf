module "resource_group" {
  source  = "aztfmod/caf-resource-group/azurerm"
  version = "0.1.1"

  prefix          = var.prefix
  resource_groups = var.resource_groups_shared_egress
  tags            = local.tags
}

locals {
  HUB-EGRESS-NET = lookup(module.resource_group.names, "HUB-EGRESS-NET", null)
}


module "networking_shared_egress_vnet" {
  source  = "aztfmod/caf-virtual-network/azurerm"
  version = "2.0.0"

  convention                        = var.global_settings.convention  
  resource_group_name               = local.HUB-EGRESS-NET
  prefix                            = var.prefix
  location                          = var.location
  networking_object                 = var.networking_object
  tags                              = local.tags
  diagnostics_map                   = var.diagnostics_map
  log_analytics_workspace           = var.log_analytics_workspace
  diagnostics_settings              = var.networking_object.diagnostics
}

module "networking_shared_public_ip" {
  source  = "aztfmod/caf-public-ip/azurerm"
  version = "2.0.0"

  convention                       = var.global_settings.convention 
  name                             = var.ip_addr_config.ip_name
  location                         = var.location
  resource_group_name              = local.HUB-EGRESS-NET
  ip_addr                          = var.ip_addr_config
  tags                             = local.tags
  diagnostics_map                  = var.diagnostics_map
  log_analytics_workspace_id       = var.log_analytics_workspace.id
  diagnostics_settings             = var.ip_addr_config.diagnostics
}

module "networking_shared_egress_azfirewall" {
  source  = "aztfmod/caf-azure-firewall/azurerm"
  version = "2.0.0"

  convention                        = var.global_settings.convention 
  name                              = var.az_fw_config.name
  resource_group_name               = local.HUB-EGRESS-NET
  subnet_id                         = lookup(module.networking_shared_egress_vnet.vnet_subnets, "AzureFirewallSubnet", null)
  public_ip_id                      = module.networking_shared_public_ip.id
  location                          = var.location
  tags                              = local.tags
  diagnostics_map                   = var.diagnostics_map
  la_workspace_id                   = var.log_analytics_workspace.id
  diagnostics_settings              = var.az_fw_config.diagnostics
}

module "firewall_rules" {
  source = "./az_firewall_rules"
  
  az_firewall_settings                 = module.networking_shared_egress_azfirewall.az_firewall_config
}

module "egress_dashboard" {
  source = "./dashboard"

  fw_id       = module.networking_shared_egress_azfirewall.id
  pip_id      = module.networking_shared_public_ip.id
  location    = var.location
  rg          = local.HUB-EGRESS-NET
  name        = basename(abspath(path.module))
  tags        = local.tags
}

module "user_route_egress_to_az_firewall" {
  source = "git://github.com/aztfmod/route_table.git?ref=v0.2"

  route_name                        = var.udr_object.route_name
  route_resource_group              = local.HUB-EGRESS-NET
  location                          = var.location
  route_prefix                      = var.udr_object.prefix
  route_nexthop_type                = var.udr_object.nexthop_type
  route_nexthop_ip                  = module.networking_shared_egress_azfirewall.az_firewall_config.az_ipconfig[0].private_ip_address
  tags                              = local.tags
}

resource "azurerm_virtual_network_peering" "peering_shared_services_to_egress" {
  depends_on                    = [ module.networking_shared_egress_vnet ]

  name                          = "shared_services_to_egress"
  resource_group_name           = var.virtual_network_rg.names["HUB-CORE-NET"]
  virtual_network_name          = var.shared_services_vnet_object.vnet_name
  remote_virtual_network_id     = module.networking_shared_egress_vnet.vnet_obj.id
  allow_virtual_network_access  = true
  allow_forwarded_traffic       = true
}

resource "azurerm_virtual_network_peering" "peering_egress_to_shared_services" {
  name                          = "egress_to_shared_services"
  depends_on                    = [ module.networking_shared_egress_vnet ]

  resource_group_name           = local.HUB-EGRESS-NET
  virtual_network_name          = module.networking_shared_egress_vnet.vnet_obj.name
  remote_virtual_network_id     = var.shared_services_vnet_object.vnet_id
  allow_virtual_network_access  = false
  allow_forwarded_traffic       = true
}
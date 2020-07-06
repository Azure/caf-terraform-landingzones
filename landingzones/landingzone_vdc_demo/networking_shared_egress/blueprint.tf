resource "azurecaf_naming_convention" "rg_network_egress" {
  name          = var.resource_groups_shared_egress.HUB-EGRESS-NET.name
  prefix        = var.prefix != "" ? var.prefix : null
  resource_type = "azurerm_resource_group"
  convention    = var.global_settings.convention
}

resource "azurerm_resource_group" "rg_network_egress" {
  name     = azurecaf_naming_convention.rg_network_egress.result
  location = var.resource_groups_shared_egress.HUB-EGRESS-NET.location
  tags     = local.tags
}

module "networking_shared_egress_vnet" {
  source = "github.com/aztfmod/terraform-azurerm-caf-virtual-network?ref=vnext"
  # source  = "aztfmod/caf-virtual-network/azurerm"
  # version = "3.0.0"

  convention              = var.global_settings.convention
  resource_group_name     = azurerm_resource_group.rg_network_egress.name
  prefix                  = var.prefix
  location                = var.location
  networking_object       = var.networking_object
  tags                    = local.tags
  diagnostics_map         = var.diagnostics_map
  log_analytics_workspace = var.log_analytics_workspace
  diagnostics_settings    = var.networking_object.diagnostics
}

module "networking_shared_public_ip" {
  source = "github.com/aztfmod/terraform-azurerm-caf-public-ip?ref=vnext"
  # source  = "aztfmod/caf-public-ip/azurerm"
  # version = "2.0.0"

  convention                 = var.global_settings.convention
  name                       = var.ip_addr_config.ip_name
  location                   = var.location
  resource_group_name        = azurerm_resource_group.rg_network_egress.name
  ip_addr                    = var.ip_addr_config
  tags                       = local.tags
  diagnostics_map            = var.diagnostics_map
  log_analytics_workspace_id = var.log_analytics_workspace.id
  diagnostics_settings       = var.ip_addr_config.diagnostics
}

module "networking_shared_egress_azfirewall" {
  source = "github.com/aztfmod/terraform-azurerm-caf-azure-firewall?ref=vnext"
  # source  = "aztfmod/caf-azure-firewall/azurerm"
  # version = "2.0.0"

  convention           = var.global_settings.convention
  name                 = var.az_fw_config.name
  resource_group_name  = azurerm_resource_group.rg_network_egress.name
  subnet_id            = lookup(module.networking_shared_egress_vnet.vnet_subnets, "AzureFirewallSubnet", null)
  public_ip_id         = module.networking_shared_public_ip.id
  location             = var.location
  tags                 = local.tags
  diagnostics_map      = var.diagnostics_map
  la_workspace_id      = var.log_analytics_workspace.id
  diagnostics_settings = var.az_fw_config.diagnostics
}

module "firewall_rules" {
  source = "./az_firewall_rules"

  az_firewall_settings = module.networking_shared_egress_azfirewall.az_firewall_config
}

module "egress_dashboard" {
  source = "./dashboard"

  fw_id    = module.networking_shared_egress_azfirewall.id
  pip_id   = module.networking_shared_public_ip.id
  location = var.location
  rg       = azurerm_resource_group.rg_network_egress.name
  name     = basename(abspath(path.module))
  tags     = local.tags
}

module "user_route_egress_to_az_firewall" {
  source = "git://github.com/aztfmod/route_table.git?ref=v0.2"

  route_name           = var.udr_object.route_name
  route_resource_group = azurerm_resource_group.rg_network_egress.name
  location             = var.location
  route_prefix         = var.udr_object.prefix
  route_nexthop_type   = var.udr_object.nexthop_type
  route_nexthop_ip     = module.networking_shared_egress_azfirewall.az_firewall_config.az_ipconfig[0].private_ip_address
  tags                 = local.tags
}

resource "azurerm_virtual_network_peering" "peering_shared_services_to_egress" {
  depends_on = [module.networking_shared_egress_vnet]

  name                         = "shared_services_to_egress"
  resource_group_name          = var.virtual_network_rg.name
  virtual_network_name         = var.shared_services_vnet_object.vnet_name
  remote_virtual_network_id    = module.networking_shared_egress_vnet.vnet_obj.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "peering_egress_to_shared_services" {
  name       = "egress_to_shared_services"
  depends_on = [module.networking_shared_egress_vnet]

  resource_group_name          = azurerm_resource_group.rg_network_egress.name
  virtual_network_name         = module.networking_shared_egress_vnet.vnet_obj.name
  remote_virtual_network_id    = var.shared_services_vnet_object.vnet_id
  allow_virtual_network_access = false
  allow_forwarded_traffic      = true
}
## Create the RG for the spoke
resource "azurecaf_naming_convention" "rg_virtualwan_spoke" {
  name          = var.spokes.spoke1.rg.name
  prefix        = local.prefix != "" ? local.prefix : null
  resource_type = "azurerm_resource_group"
  convention    = local.global_settings.convention
  max_length    = 25
}

resource "azurerm_resource_group" "rg_virtualwan_spoke" {
  name     = azurecaf_naming_convention.rg_virtualwan_spoke.result
  location = var.spokes.spoke1.rg.location
  tags     = local.tags
}

## Create a spoke VNET 
module "virtual_network" {
  # source = "github.com/aztfmod/terraform-azurerm-caf-virtual-network?ref=vnext"
  source  = "aztfmod/caf-virtual-network/azurerm"
  version = "3.1.0"

  convention              = local.global_settings.convention
  resource_group_name     = azurerm_resource_group.rg_virtualwan_spoke.name
  prefix                  = local.prefix
  location                = local.global_settings.location_map.region1
  networking_object       = var.spokes.spoke1.network
  tags                    = local.tags
  diagnostics_map         = local.caf_foundations_accounting.diagnostics_map
  log_analytics_workspace = local.caf_foundations_accounting.log_analytics_workspace
  diagnostics_settings    = var.spokes.spoke1.network.diagnostics
  max_length              = 25
}

# TODO TF13: iterate on hubs and spokes
# Create the peering between spoke vnet and hub
# resource "azurerm_virtual_hub_connection" "hub_to_spoke" {
#   name                      = var.spokes.spoke1.peering_name

#   virtual_hub_id            = module.virtual_hub_region2.id
#   remote_virtual_network_id = module.virtual_network.vnet.vnet_id

#   hub_to_vitual_network_traffic_allowed = var.virtual_hub_config.virtual_wan.hubs.hub2.peerings.spoke1.hub_to_vitual_network_traffic_allowed
#   vitual_network_to_hub_gateways_traffic_allowed = var.virtual_hub_config.virtual_wan.hubs.hub2.peerings.spoke1.vitual_network_to_hub_gateways_traffic_allowed
#   # optional fields:
#   internet_security_enabled = lookup(var.virtual_hub_config.virtual_wan.hubs.hub2.peerings.spoke1,"internet_security_enabled", null)
# }
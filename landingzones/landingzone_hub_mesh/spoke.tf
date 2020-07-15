## Create the name and RG for each spoke
resource "azurecaf_naming_convention" "rg_virtualwan_spoke" {
  for_each = var.spokes

  name          = each.value.rg.name
  prefix        = local.prefix != "" ? local.prefix : null
  resource_type = "azurerm_resource_group"
  convention    = local.global_settings.convention
  max_length    = 25
}

resource "azurerm_resource_group" "rg_virtualwan_spoke" {
  for_each = var.spokes

  name     = azurecaf_naming_convention.rg_virtualwan_spoke[each.key].result
  location = each.value.rg.location
  tags     = local.tags
}

## Create the spoke VNET 
module "virtual_network" {
  source = "github.com/aztfmod/terraform-azurerm-caf-virtual-network?ref=vnext"
  for_each = var.spokes
  # source  = "aztfmod/caf-virtual-network/azurerm"
  # version = "3.0.0"

  convention              = local.global_settings.convention
  resource_group_name     = azurerm_resource_group.rg_virtualwan_spoke[each.key].name
  prefix                  = local.prefix
  location                = local.global_settings.location_map.region1
  networking_object       = each.value.network
  tags                    = local.tags
  diagnostics_map         = local.caf_foundations_accounting.diagnostics_map
  log_analytics_workspace = local.caf_foundations_accounting.log_analytics_workspace
  diagnostics_settings    = each.value.network.diagnostics
}

# Create the peering between hub and spoke vnet
# resource "azurerm_virtual_hub_connection" "hub_to_spoke" {
#   for_each = var.virtual_hub_config.virtual_wan.hubs
  
#   virtual_hub_id            = module.virtual_hub[each.key].id
#   remote_virtual_network_id = module.virtual_network[keys(each.value.peerings)].vnet.vnet_id
#   name                      = var.spokes[each.key].peering_name

#   hub_to_vitual_network_traffic_allowed = var.virtual_hub_config.virtual_wan.hubs.hub2.peerings.spoke1.hub_to_vitual_network_traffic_allowed
#   vitual_network_to_hub_gateways_traffic_allowed = var.virtual_hub_config.virtual_wan.hubs.hub2.peerings.spoke1.vitual_network_to_hub_gateways_traffic_allowed
#   # optional fields:
#   internet_security_enabled = lookup(var.virtual_hub_config.virtual_wan.hubs.hub2.peerings.spoke1,"internet_security_enabled", null)
# }

module "resource_groups" {
    source  = "aztfmod/caf-resource-group/azurerm"
    version = "~>0.1.0"
  
    prefix          = var.prefix
    resource_groups = var.resource_groups
    tags            = local.tags
}

module "virtual_network_region1" {
    source  = "aztfmod/caf-virtual-network/azurerm"
    version = "~>0.1.0"

    virtual_network_rg          = module.resource_groups.object.rg1.name
    prefix                      = var.prefix
    location                    = var.networking.region1.location
    networking_object           = var.networking.region1
    tags                        = local.tags
    diagnostics_map             = var.diagnostics_map
    log_analytics_workspace     = var.log_analytics_workspace
}

# Create an additional diagnostics
# Workaround until level1_vdc_operation implements a diagnostic repo per location
module "caf_diagnostics_logging_region2" {
    source  = "aztfmod/caf-diagnostics-logging/azurerm"
    version = "0.1.0"
  
    prefix                      = var.prefix
    resource_group_name         = module.resource_groups.object.rg2.name
    location                    = var.networking.region2.location
    tags                        = local.tags
}

module "virtual_network_region2" {
    source  = "aztfmod/caf-virtual-network/azurerm"
    version = "~>0.1.0"

    virtual_network_rg          = module.resource_groups.object.rg2.name
    prefix                      = var.prefix
    location                    = var.networking.region2.location
    networking_object           = var.networking.region2
    tags                        = local.tags
    diagnostics_map             = module.caf_diagnostics_logging_region2.diagnostics_map
    log_analytics_workspace     = var.log_analytics_workspace
}

locals {
    networking_keys = keys(var.networking)
}


# Peer the two vnet
resource "azurerm_virtual_network_peering" "region1_to_region2" {
  name                      = "peering-to-${var.networking.region2.vnet.name}"
  resource_group_name       = module.resource_groups.object.rg1.name
  virtual_network_name      = module.virtual_network_region1.vnet.vnet_name
  remote_virtual_network_id = module.virtual_network_region2.vnet.vnet_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true

  # `allow_gateway_transit` must be set to false for vnet Global Peering
  allow_gateway_transit = false
}

resource "azurerm_virtual_network_peering" "region2_to_region1" {
  name                      = "peering-to-${var.networking.region1.vnet.name}"
  resource_group_name       = module.resource_groups.object.rg2.name
  virtual_network_name      = module.virtual_network_region2.vnet.vnet_name
  remote_virtual_network_id = module.virtual_network_region1.vnet.vnet_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true

  # `allow_gateway_transit` must be set to false for vnet Global Peering
  allow_gateway_transit = false
}
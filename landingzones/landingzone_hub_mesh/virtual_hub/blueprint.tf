resource "azurerm_resource_group" "rg_virtualhub_fw" {
  name     = "${var.rg}-fw-${var.virtual_hub_config.firewall_name}"
  location = var.global_settings.location_map.region1
  tags     = var.global_settings.tags_hub
}

## Azure Virtual WAN
## Need to add diagnostics, tags, etc. 
module "virtual_hub" {
  source = "./virtual_hub"

  vwan                              = var.virtual_hub_config
  vwan_id                           = var.vwan_id
  rg                                = var.rg
  location                          = var.location
  tags                              = local.tags
}

## Azure Firewall for Virtual WAN
module "virtual_hub_firewall" {
  source = "./virtual_hub_firewall"

  vwan_id                           = module.virtual_hub.id
  name                              = var.virtual_hub_config.firewall_name
  rg                                = azurerm_resource_group.rg_virtualhub_fw.name
  location                          = var.location
  tags                              = local.tags
}


## Add Azure Policy for Azure Firewall for Virtual WAN 

## Azure Azure Firewall Dashboard for Virtual WAN
# module "firewall_dashboard" {
#   source = "./firewall_dashboard"

#   fw_id       = module.virtual_wan_firewall.id
#   pip_id      = module.virtual_wan_firewall.id
#   location    = var.location
#   rg          = azurerm_resource_group.rg_virtualhub.name
#   name        = basename(abspath(path.module))
#   tags        = var.global_settings.tags_hub
# }


## naming conventions
resource "azurecaf_naming_convention" "vwan_hub" {
  name          = var.virtual_hub_config.hub_name
  prefix        = var.prefix != "" ? var.prefix : null
  resource_type = "azurerm_virtual_network"
  convention    = var.global_settings.convention
  max_length    = 20
}

resource "azurecaf_naming_convention" "s2s_gateway" {
  count = var.virtual_hub_config.deploy_s2s ? 1 : 0

  name          = lookup(var.virtual_hub_config.s2s_config, "name", null)
  prefix        = var.prefix != "" ? var.prefix : null
  resource_type = "azurerm_virtual_network"
  convention    = var.global_settings.convention
}

resource "azurecaf_naming_convention" "p2s_gateway" {
  count = var.virtual_hub_config.deploy_p2s ? 1 : 0

  name          = lookup(var.virtual_hub_config.p2s_config, "name", null)
  prefix        = var.prefix != "" ? var.prefix : null
  resource_type = "azurerm_virtual_network"
  convention    = var.global_settings.convention
}

resource "azurecaf_naming_convention" "er_gateway" {
  count = var.virtual_hub_config.deploy_er ? 1 : 0

  name          = lookup(var.virtual_hub_config.er_config, "name", null)
  prefix        = var.prefix != "" ? var.prefix : null
  resource_type = "azurerm_virtual_network"
  convention    = var.global_settings.convention
}

## creates a virtual hub in the region
resource "azurerm_virtual_hub" "vwan_hub" {
  name                = azurecaf_naming_convention.vwan_hub.result
  resource_group_name = var.resource_group_name
  location            = var.location
  virtual_wan_id      = var.vwan_id
  address_prefix      = var.virtual_hub_config.hub_address_prefix
  tags                = local.tags

  timeouts {
    create = "60m"
    delete = "180m"
  }
}

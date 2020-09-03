
## create the VPN P2S if var.vwan.p2s_gateway is set to true 
resource "azurerm_point_to_site_vpn_gateway" "p2s_gateway" {
  depends_on = [azurerm_virtual_hub.vwan_hub, azurerm_vpn_server_configuration.p2s_configuration]

  count = var.virtual_hub_config.deploy_p2s ? 1 : 0

  name                        = azurecaf_naming_convention.p2s_gateway.0.result
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tags                        = local.tags
  virtual_hub_id              = azurerm_virtual_hub.vwan_hub.id
  vpn_server_configuration_id = azurerm_vpn_server_configuration.p2s_configuration[0].id

  scale_unit = var.virtual_hub_config.p2s_config.scale_unit

  dynamic "connection_configuration" {
    for_each = lookup(var.virtual_hub_config.p2s_config, "connection_configuration", {}) != {} ? [1] : []

    content {
      name = var.virtual_hub_config.p2s_config.connection_configuration.name

      dynamic "vpn_client_address_pool" {
        for_each = var.virtual_hub_config.p2s_config.connection_configuration.vpn_client_address_pool
        content {
          address_prefixes = var.virtual_hub_config.p2s_config.connection_configuration.vpn_client_address_pool.address_prefixes
        }
      }
    }
  }

  timeouts {
    create = "60m"
    delete = "120m"
  }

}

# ## creates the VPN P2S server configuration, this is required for P2S site.
# ## TBD: https://www.terraform.io/docs/providers/azurerm/r/vpn_server_configuration.html
resource "azurerm_vpn_server_configuration" "p2s_configuration" {
  depends_on = [azurerm_virtual_hub.vwan_hub]
  count      = var.virtual_hub_config.deploy_p2s ? 1 : 0

  name                     = azurecaf_naming_convention.p2s_gateway.0.result
  resource_group_name      = var.resource_group_name
  location                 = var.location
  tags                     = local.tags
  vpn_authentication_types = var.virtual_hub_config.p2s_config.server_config.vpn_authentication_types

  client_root_certificate {
    name             = var.virtual_hub_config.p2s_config.server_config.client_root_certificate.name
    public_cert_data = var.virtual_hub_config.p2s_config.server_config.client_root_certificate.public_cert_data
  }

}


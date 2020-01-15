# module "diagnostics_vpn" {
#   source  = "aztfmod/caf-diagnostics/azurerm"
#   version = "0.1.1"
  
#     #depends_on = [azurerm_virtual_network_gateway.vpn_gateway]
#     #count = "${var.gateway_config.gateway_type == "VPN" && var.provision_gateway ? 1 : 0}"

#     name                            = azurerm_virtual_network_gateway.vpn_gateway[0].name
#     resource_id                     = azurerm_virtual_network_gateway.vpn_gateway[0].id
#     log_analytics_workspace_id      = var.log_analytics_workspace.id
#     diagnostics_map                 = var.diagnostics_map
#     diag_object                     = var.diagnostics_settings
# }
module "diagnostics_vpn" {
  source  = "aztfmod/caf-diagnostics/azurerm"
  version = "0.1.1"
  
    name                            = azurerm_virtual_network_gateway.vpn_gateway.*.name
    resource_id                     = azurerm_virtual_network_gateway.vpn_gateway.*.id
    log_analytics_workspace_id      = var.log_analytics_workspace.id
    diagnostics_map                 = var.diagnostics_map
    diag_object                     = var.gateway_diags
}
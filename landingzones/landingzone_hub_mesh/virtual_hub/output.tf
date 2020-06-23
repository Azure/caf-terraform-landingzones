output "id" {
  description = "Resource ID of the Virtual Hub"
  value       = azurerm_virtual_hub.vwan_hub.id
}

output "object" {
  description = "Full Virtual Hub Object"
  value       = azurerm_virtual_hub.vwan_hub
}

output "name" {
  description = "Name of the Virtual Hub"
  value       = azurerm_virtual_hub.vwan_hub.name
}

output "firewall_id" {
  description = "Resource ID of the Azure Firewall for Virtual Hub"
  value       = var.virtual_hub_config.deploy_firewall ? azurerm_template_deployment.arm_template_vhub_firewall.*.outputs.resourceID : null
}

# output virtual network gateway objects: p2s, s2s, er objects
output "er_gateway" {
  description = "Full Object for Virtual Network Gateway - Express Route"
  value       = var.virtual_hub_config.deploy_er ? azurerm_express_route_gateway.er_gateway.0 : null
}

output "s2s_gateway" {
  description = "Full Object for Virtual Network Gateway - Site 2 Site"
  value       = var.virtual_hub_config.deploy_s2s ? azurerm_vpn_gateway.s2s_gateway.0 : null
}

output "p2s_gateway" {
  description = "Full Object for Virtual Network Gateway - Point to Site"
  value       = var.virtual_hub_config.deploy_p2s ? azurerm_point_to_site_vpn_gateway.p2s_gateway.0 : null
}

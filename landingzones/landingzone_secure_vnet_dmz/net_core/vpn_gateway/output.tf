output "object" {
  value = azurerm_virtual_network_gateway.vpn_gateway
}

output "remote_connection_object" {
  value = azurerm_local_network_gateway.remote_network
}

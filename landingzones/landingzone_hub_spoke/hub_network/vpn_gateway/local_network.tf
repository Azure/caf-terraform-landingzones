resource "azurerm_local_network_gateway" "remote_network" {
  
  name                = var.remote_network.gateway_name
  resource_group_name = var.resource_group_name
  location            = var.location
  gateway_address     = var.remote_network.gateway_ip
  address_space       = var.remote_network.gateway_adress_space
  tags                = var.tags

    # bgp_settings {
    #     asn = 
    #     bgp_peering_address = 
    #     peer_weight = 
    # }
}
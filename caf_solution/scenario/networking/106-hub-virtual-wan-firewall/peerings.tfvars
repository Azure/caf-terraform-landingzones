virtual_hub_connections = {
  # Establish the peering with Virtual Hubs
  hub_rg1-TO-vnet_rg1 = {
    virtual_hub = {
      key = "hub_re1"
    }
    vnet = {
      # If the virtual network is stored in another another landing zone, use the following attributes to refer the state file:
      # lz_key      = "networking"
      # output_key  = "vnets"
      vnet_key = "vnet_re1"
    }
    name                                            = "vhub_peering_hub_1"
    hub_to_virtual_network_traffic_allowed          = true
    virtual_network_to_hub_gateways_traffic_allowed = true
    internet_security_enabled                       = true
  }
  hub_rg2-TO-vnet_rg2 = {
    virtual_hub = {
      key = "hub_re2"
    }
    vnet = {
      # If the virtual network is stored in another another landing zone, use the following attributes to refer the state file:
      # lz_key      = "networking"
      # output_key  = "vnets"
      vnet_key = "vnet_re2"
    }
    name                                            = "vhub_peering_hub_2"
    hub_to_virtual_network_traffic_allowed          = true
    virtual_network_to_hub_gateways_traffic_allowed = true
    internet_security_enabled                       = true
  }
}

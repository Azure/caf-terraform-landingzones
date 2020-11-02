
vnet_peerings = {
  hub_re1_TO_hub_re2 = {
    name = "hub_re1_TO_hub_re2"
    from = {
      vnet_key = "hub_re1"
    }
    to = {
      vnet_key = "hub_re2"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }

  hub_re2_TO_hub_re1 = {
    name = "hub_re2_TO_hub_re1"
    from = {
      vnet_key = "hub_re2"
    }
    to = {
      vnet_key = "hub_re1"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }

}

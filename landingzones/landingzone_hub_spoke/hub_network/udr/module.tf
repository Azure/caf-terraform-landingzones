#Reference https://www.terraform.io/docs/providers/azurerm/r/route_table.html  

resource "azurerm_route_table" "user_route" {
  name                          = var.route_name
  location                      = var.location
  resource_group_name           = var.route_resource_group
  disable_bgp_route_propagation = false

  tags                          = var.tags
  route {
    name                        = var.route_name
    address_prefix              = var.route_prefix
    next_hop_type               = var.route_nexthop_type
    //theoritcally should be: next_hop_in_ip_address      = var.route_nexthop_type == "VirtualAppliance" ? "${var.route_nexthop_ip}" : null
    next_hop_in_ip_address      = var.route_nexthop_ip
  }
}

resource "azurerm_subnet_route_table_association" "route_subnet_association" {
  subnet_id      = var.subnet_id
  route_table_id = azurerm_route_table.user_route.id
}
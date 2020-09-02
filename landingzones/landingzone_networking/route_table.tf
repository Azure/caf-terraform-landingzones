resource "azurerm_route_table" "route_table" {
  for_each = var.route_tables

  name                          = each.value.name
  location                      = lookup(each.value, "location", local.global_settings.default_location)
  resource_group_name           = azurerm_resource_group.rg[each.value.resource_group_key].name
  tags                          = local.tags
  disable_bgp_route_propagation = lookup(each.value, "disable_bgp_route_propagation", null)

  dynamic "route" {
    for_each = each.value.route_entries
    content {
      name                   = route.value.name
      address_prefix         = route.value.prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = (route.value.next_hop_type == "VirtualAppliance") ? (contains(keys(route.value), "azfw") == true ? module.az_firewall[route.value.azfw.VirtualAppliance_key].object.ip_configuration[route.value.azfw.ipconfig_index].private_ip_address : route.value.next_hop_in_ip_address) : null
    }
  }
}


resource "azurerm_virtual_network_peering" "peering" {
  for_each = var.peerings

  name                         = each.value.name
  resource_group_name          = lookup(each.value, "resource_group_name", module.vnets[each.value.from_key].vnet_obj.resource_group_name)
  virtual_network_name         = lookup(each.value, "virtual_network_name", module.vnets[each.value.from_key].vnet_obj.name)
  remote_virtual_network_id    = lookup(each.value, "remote_virtual_network_id", module.vnets[each.value.to_key].vnet_obj.id)
  allow_virtual_network_access = lookup(each.value, "allow_virtual_network_access", false)
  allow_forwarded_traffic      = lookup(each.value, "allow_forwarded_traffic", false)
  allow_gateway_transit        = lookup(each.value, "allow_gateway_transit", false)
  use_remote_gateways          = lookup(each.value, "use_remote_gateways", false)
}
 
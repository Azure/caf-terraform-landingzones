resource "azurerm_subnet_route_table_association" "route_subnet" {
  for_each = var.route_tables

  subnet_id      = module.vnets[each.value.vnet_key].vnet_subnets[each.value.subnet_key]
  route_table_id = azurerm_route_table.route_table[each.key].id
}

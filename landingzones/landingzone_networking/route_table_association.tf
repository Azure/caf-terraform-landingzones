resource "azurerm_subnet_route_table_association" "route_subnet" {
  depends_on = [azurerm_route_table.route_table]
  
  for_each = var.route_tables

  subnet_id      = module.vnets[each.value.vnet_key].vnet_subnets[each.value.subnet_key]
  route_table_id = azurerm_route_table.route_table[each.key].id
}

locals {
  route_tables_subnets = {
    for key, value in var.route_tables : key => flatten([
      for vnet_key, vnet_value in lookup(value, "vnet_keys", []) : [
        for subnet in lookup(vnet_value, "subnet_keys", []) : module.vnets[vnet_key].vnet_subnets[subnet]
      ]
    ])
  }
}

resource "azurerm_subnet_route_table_association" "route_subnet" {
  depends_on = [azurerm_route_table.route_table]

  for_each = transpose(local.route_tables_subnets)

  subnet_id      = each.key
  route_table_id = azurerm_route_table.route_table[each.value[0]].id
}


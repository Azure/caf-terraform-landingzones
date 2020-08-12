locals {
  # flatten ensures that this local value is a flat list of objects, rather
  # than a list of lists of objects.
  route_tables_subnets = {
    for key, value in var.route_tables : key => flatten([
      for vnet_key, vnet_value in lookup(value,"vnet_keys",[]) : [
        for subnet in lookup(vnet_value,"subnet_keys",[]) : module.vnets[vnet_key].vnet_subnets[subnet]
      ]
    ])
  }
}

# output "route_tables_subnets" {
#   value = local.route_tables_subnets
# }
# route_tables_subnets = {
#   "from_spoke_to_hub" = [
#     [
#       "/subscriptions/30e02b61-1190-4a13-9a5e-1303a1e5f87b/resourceGroups/klfa-rg-vnet-hub-sg-uBDYszHuunEBjkXR5kGy/providers/Microsoft.Network/virtualNetworks/klfa-vnet-aks-gEst1wyIqg2sMo6MXuqi0e7gKy6gs2lhzlqJpUECz3oUub/subnets/aks_nodepool_system",
#       "/subscriptions/30e02b61-1190-4a13-9a5e-1303a1e5f87b/resourceGroups/klfa-rg-vnet-hub-sg-uBDYszHuunEBjkXR5kGy/providers/Microsoft.Network/virtualNetworks/klfa-vnet-aks-gEst1wyIqg2sMo6MXuqi0e7gKy6gs2lhzlqJpUECz3oUub/subnets/aks_nodepool_user1",
#     ],
#   ]
# }

resource "azurerm_subnet_route_table_association" "route_subnet" {
  depends_on = [azurerm_route_table.route_table]
  
  for_each = transpose(local.route_tables_subnets)

  subnet_id      = each.key
  route_table_id = azurerm_route_table.route_table[each.value[0]].id
}


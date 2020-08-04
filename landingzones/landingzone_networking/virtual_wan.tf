## Create the global virtual WAN
resource "azurerm_virtual_wan" "vwan" {
  for_each = var.vwans

  name                = each.value.name
  resource_group_name = azurerm_resource_group.rg[each.value.resource_group_key].name
  location            = each.key
  tags                = local.tags

  type                              = lookup(each.value, "type", null)
  disable_vpn_encryption            = lookup(each.value, "disable_vpn_encryption", null)
  allow_branch_to_branch_traffic    = lookup(each.value, "allow_branch_to_branch_traffic", null)
  allow_vnet_to_vnet_traffic        = lookup(each.value, "allow_vnet_to_vnet_traffic", null)
  office365_local_breakout_category = lookup(each.value, "office365_local_breakout_category", null)
}

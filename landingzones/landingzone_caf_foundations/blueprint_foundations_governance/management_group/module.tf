resource "azurerm_management_group" "parent_management_group" {
  #can potentially have multiple roots created
  for_each            = var.management_groups
    display_name      = each.value.name
    subscription_ids  = each.value.subscriptions
}

resource "azurerm_management_group" "l1children" {
  #iterate on level1 children for the first root
  for_each                      = var.management_groups.root.children
    parent_management_group_id  = azurerm_management_group.parent_management_group["root"].id
    display_name                = each.value.name
    subscription_ids            = each.value.subscriptions
}
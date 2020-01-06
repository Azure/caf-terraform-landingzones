
resource "azurerm_management_group" "parent_management_group" {
  for_each = var.management_groups
  display_name     = each.value.name
  subscription_ids = each.value.subscriptions
}

resource "azurerm_management_group" "l1children" {
    
  for_each = var.management_groups.children
  
  parent_management_group_id  = azurerm_management_group.parent_management_group.id
  display_name                = each.value.name
  subscription_ids            = each.value.subscriptions
}

resource "azurerm_management_group" "l2children" {
    
  for_each = var.management_groups.children.children
  
  parent_management_group_id  = azurerm_management_group.parent_management_group.children.id
  display_name                = each.value.name
  subscription_ids            = each.value.subscriptions
}
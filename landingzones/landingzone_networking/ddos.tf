resource "azurerm_network_ddos_protection_plan" "ddos_protection_plan" {
  for_each = var.ddos_services

  name                = each.value.name
  location            = each.value.location
  resource_group_name = azurerm_resource_group.rg[each.value.resource_group_key].name
  tags                = local.tags
}
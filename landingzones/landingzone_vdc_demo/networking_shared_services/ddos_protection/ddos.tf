## Cant be deleted or modified as per https://github.com/terraform-providers/terraform-provider-azurerm/issues/4059 

resource "azurerm_network_ddos_protection_plan" "ddos_protection_plan" {
  count = var.enable_ddos_standard ? 1 : 0

  name                = var.name
  location            = var.location
  resource_group_name = var.rg
  tags                = var.tags
}
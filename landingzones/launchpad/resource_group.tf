
resource "azurecaf_naming_convention" "rg" {
  name          = var.resource_group_name
  resource_type = "azurerm_resource_group"
  convention    = var.convention
  prefix        = local.prefix
}

resource "azurerm_resource_group" "rg" {
  name     = azurecaf_naming_convention.rg.result
  location = var.location

  tags = local.tags
}

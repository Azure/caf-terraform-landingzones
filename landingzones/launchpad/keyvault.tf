
resource "azurecaf_naming_convention" "keyvault" {
  for_each = var.keyvaults

  name          = each.value.name
  resource_type = "kv"
  convention    = each.value.convention
  prefix        = local.prefix_start_alpha
}

resource "azurerm_key_vault" "keyvault" {
  for_each = {
    for key, keyvault in var.keyvaults : key => keyvault
  }

  name                = azurecaf_naming_convention.keyvault[each.key].result
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name = each.value.sku_name

  tags = {
    tfstate     = var.level
    environment = var.environment
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = var.logged_user_objectId

    key_permissions    = []
    secret_permissions = ["Get", "List", "Set", "Delete"]
  }

  lifecycle {
    ignore_changes = [
      access_policy
    ]
  }

}



resource "azurecaf_naming_convention" "account" {
  for_each = var.aad_users

  name          = each.value.user_name
  prefix        = each.value.useprefix ? local.prefix : ""
  resource_type = "rg" # workaround to keep the dashes
  convention    = lookup(each.value, "convention", local.global_settings.convention)
  max_length    = lookup(each.value, "max_length", null)
}

# 
#
resource "azuread_user" "account" {
  for_each = var.aad_users

  user_principal_name = "${azurecaf_naming_convention.account[each.key].result}@${each.value.tenant_name}"
  display_name        = "${azurecaf_naming_convention.account[each.key].result} (created by CAF launchpad)"
  password            = random_password.account[each.key].result
}


resource "random_password" "account" {
  for_each = var.aad_users

  length  = 250
  special = false
  upper   = true
  number  = true
}


resource "azurerm_key_vault_secret" "aad_user_name" {
  depends_on = [
    azurerm_key_vault.keyvault
  ]

  for_each = var.aad_users

  name         = "${lookup(each.value, "secret_prefix", each.value.user_name)}-name"
  value        = azuread_user.account[each.key].user_principal_name
  key_vault_id = azurerm_key_vault.keyvault[each.value.keyvault_key].id
}

resource "azurerm_key_vault_secret" "aad_user_password" {
  depends_on = [
    azurerm_key_vault.keyvault
  ]

  for_each = var.aad_users

  name         = "${lookup(each.value, "secret_prefix", each.value.user_name)}-password"
  value        = random_password.account[each.key].result
  key_vault_id = azurerm_key_vault.keyvault[each.value.keyvault_key].id
}
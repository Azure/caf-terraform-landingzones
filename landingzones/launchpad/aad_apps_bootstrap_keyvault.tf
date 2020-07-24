resource "azurerm_key_vault_secret" "launchpad_blob_name" {
  name         = "launchpad-blob-name"
  value        = var.tf_name
  key_vault_id = azurerm_key_vault.keyvault[var.launchpad_key_names.keyvault].id
}

resource "azurerm_key_vault_secret" "launchpad_blob_container" {
  name         = "launchpad-blob-container"
  value        = azurerm_storage_container.launchpad.name
  key_vault_id = azurerm_key_vault.keyvault[var.launchpad_key_names.keyvault].id
}

resource "azurerm_key_vault_secret" "launchpad_name" {
  name         = "launchpad-secret-prefix"
  value        = var.aad_apps[var.launchpad_key_names.aad_app].keyvault.secret_prefix
  key_vault_id = azurerm_key_vault.keyvault[var.launchpad_key_names.keyvault].id
}


resource "azurerm_key_vault_secret" "launchpad_subscription_id" {
  name         = "launchpad-subscription-id"
  value        = data.azurerm_client_config.current.subscription_id
  key_vault_id = azurerm_key_vault.keyvault[var.launchpad_key_names.keyvault].id
}

# launchpad_light or launchpad
resource "azurerm_key_vault_secret" "launchpad_mode" {
  name         = "launchpad-mode"
  value        = var.launchpad_mode
  key_vault_id = azurerm_key_vault.keyvault[var.launchpad_key_names.keyvault].id
}


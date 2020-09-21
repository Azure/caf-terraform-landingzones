resource "azurerm_key_vault_secret" "launchpad_blob_name" {
  depends_on   = [module.launchpad]
  name         = "launchpad-blob-name"
  value        = var.tf_name
  key_vault_id = module.launchpad.keyvaults[var.launchpad_key_names.keyvault].id
}

resource "azurerm_key_vault_secret" "launchpad_blob_container_legacy" {
  depends_on   = [module.launchpad]
  name         = "launchpad-blob-container"
  value        = "tfstate"
  key_vault_id = module.launchpad.keyvaults["launchpad"].id
}

resource "azurerm_key_vault_secret" "launchpad_blob_container" {
  for_each = {
    for key in var.launchpad_key_names.tfstates : key => key
  }

  depends_on   = [module.launchpad]
  name         = format("launchpad-blob-container-%s", each.value)
  value        = "tfstate"
  key_vault_id = module.launchpad.keyvaults[var.launchpad_key_names.keyvault].id
}

resource "azurerm_key_vault_secret" "launchpad-secret-prefix" {
  depends_on   = [module.launchpad]
  name         = "launchpad-secret-prefix"
  value        = var.launchpad_key_names.keyvault_client_secret
  key_vault_id = module.launchpad.keyvaults[var.launchpad_key_names.keyvault].id
}


resource "azurerm_key_vault_secret" "launchpad_subscription_id" {
  depends_on   = [module.launchpad]
  name         = "launchpad-subscription-id"
  value        = data.azurerm_client_config.current.subscription_id
  key_vault_id = module.launchpad.keyvaults[var.launchpad_key_names.keyvault].id
}

# launchpad_light or launchpad
resource "azurerm_key_vault_secret" "launchpad_mode" {
  depends_on   = [module.launchpad]
  name         = "launchpad-mode"
  value        = var.launchpad_mode
  key_vault_id = module.launchpad.keyvaults[var.launchpad_key_names.keyvault].id
}


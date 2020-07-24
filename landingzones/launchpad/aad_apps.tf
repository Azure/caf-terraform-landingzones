module azure_applications {
  source  = "aztfmod/caf-aad-apps/azuread"
  version = "1.0.0"

  aad_apps            = var.aad_apps
  aad_api_permissions = var.aad_api_permissions
  keyvaults           = azurerm_key_vault.keyvault
  prefix              = local.prefix
}


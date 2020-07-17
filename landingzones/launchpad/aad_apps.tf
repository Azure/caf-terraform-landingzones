module azure_applications {
  depends_on = [azurerm_key_vault.keyvault]
  source = "github.com/aztfmod/terraform-azuread-caf-aad-apps?ref=vnext"

  aad_apps            = var.aad_apps
  aad_api_permissions = var.aad_api_permissions
  keyvaults           = azurerm_key_vault.keyvault
  prefix              = local.prefix
}


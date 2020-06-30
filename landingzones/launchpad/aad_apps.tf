module azure_applications {
  source = "github.com/aztfmod/terraform-azuread-caf-aad-apps"

  aad_apps            = var.aad_apps
  aad_api_permissions = var.aad_api_permissions
  keyvaults           = azurerm_key_vault.keyvault
  prefix              = local.prefix
}


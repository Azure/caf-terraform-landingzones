module custom_role_definition {
  source  = "aztfmod/caf-custom-role/azurerm"
  version = "1.0.0"

  custom_role_definitions = var.custom_role_definitions
  prefix                  = local.prefix
  aad_apps                = module.azure_applications.aad_apps
  subscriptions           = var.subscriptions
}

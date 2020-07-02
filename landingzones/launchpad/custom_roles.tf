module custom_role_definition {
  source = "github.com/aztfmod/terraform-azurerm-caf-custom-role"

  custom_role_definitions = var.custom_role_definitions
  prefix                  = local.prefix
  aad_apps                = module.azure_applications.aad_apps
  subscriptions           = var.subscriptions
}

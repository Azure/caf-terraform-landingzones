# For full description on enterprise_scale module usage, please refer to https://github.com/Azure/terraform-azurerm-caf-enterprise-scale

module "enterprise_scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "4.2.0"

  # source = "/tf/caf/alz"

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm.connectivity
    azurerm.management   = azurerm.management
  }

  root_parent_id   = var.root_parent_id == null ? data.azurerm_client_config.current.tenant_id : var.root_parent_id
  default_location = local.global_settings.regions[local.global_settings.default_region]

  #path to the policies definition and assignment repo
  library_path               = var.library_path
  archetype_config_overrides = local.archetype_config_overrides
  custom_landing_zones       = local.custom_landing_zones
  deploy_core_landing_zones  = var.deploy_core_landing_zones
  root_id                    = var.root_id
  root_name                  = var.root_name
  subscription_id_overrides  = local.subscription_id_overrides

  # To support native alz deployment mode
  configure_connectivity_resources = var.configure_connectivity_resources
  configure_identity_resources     = var.configure_identity_resources
  configure_management_resources   = var.configure_management_resources
  deploy_connectivity_resources    = var.deploy_connectivity_resources
  deploy_diagnostics_for_mg        = var.deploy_diagnostics_for_mg
  deploy_identity_resources        = var.deploy_identity_resources
  deploy_management_resources      = var.deploy_management_resources
  disable_telemetry                = var.disable_telemetry
  subscription_id_connectivity     = local.subscription_id_connectivity
  subscription_id_management       = local.subscription_id_management
  subscription_id_identity         = local.subscription_id_identity
  strict_subscription_association  = var.strict_subscription_association
}

locals {
  subscription_id_connectivity = var.subscription_id_connectivity == null ? data.azurerm_client_config.current.subscription_id : var.subscription_id_connectivity
  subscription_id_management   = var.subscription_id_management == null ? data.azurerm_client_config.current.subscription_id : var.subscription_id_management
  subscription_id_identity     = var.subscription_id_identity == null ? data.azurerm_client_config.current.subscription_id : var.subscription_id_identity
}

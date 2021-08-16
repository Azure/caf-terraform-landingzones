# For full description on enterprise_scale module usage, please refer to https://github.com/Azure/terraform-azurerm-caf-enterprise-scale

module "enterprise_scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "~> 0.1.0"

  root_parent_id   = data.azurerm_client_config.current.tenant_id
  default_location = local.global_settings.regions[local.global_settings.default_region]

  #path to the policies definition and assignment repo
  library_path               = var.library_path
  archetype_config_overrides = local.archetype_config_overrides
  custom_landing_zones       = local.custom_landing_zones
  deploy_core_landing_zones  = var.deploy_core_landing_zones
  root_id                    = var.root_id
  root_name                  = var.root_name
  subscription_id_overrides  = local.subscription_id_overrides
}
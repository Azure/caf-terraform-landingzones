# For full description on enterprise_scale module usage, please refer to https://github.com/Azure/terraform-azurerm-caf-enterprise-scale

module "enterprise_scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "0.0.8"

  root_parent_id = data.azurerm_client_config.current.tenant_id

  root_id                   = var.root_id
  root_name                 = var.root_name
  deploy_core_landing_zones = var.deploy_core_landing_zones

  # Control whether to deploy the demo landing zones // default = false
  deploy_demo_landing_zones = var.deploy_demo_landing_zones

  # Set a path for the custom archetype library path
  library_path = try(format("%s", var.library_path), "")

  # Deploys the custom landing zone configuration as defined in config file
  custom_landing_zones       = var.custom_landing_zones
  subscription_id_overrides  = var.subscription_id_overrides
  archetype_config_overrides = var.archetype_config_overrides

  default_location = local.global_settings.regions[local.global_settings.default_region]
}
# For full description on enterprise_scale module usage, please refer to https://github.com/Azure/terraform-azurerm-caf-enterprise-scale

module "enterprise_scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "0.0.8"

  root_parent_id = data.azurerm_client_config.current.tenant_id

  root_id                   = try(var.enterprise_scale.root_id, "es")
  root_name                 = try(var.enterprise_scale.root_name, "Enterprise-Scale")
  deploy_core_landing_zones = try(var.enterprise_scale.deploy_core_landing_zones, false)

  # Control whether to deploy the demo landing zones // default = false
  deploy_demo_landing_zones = try(var.enterprise_scale.deploy_demo_landing_zones, false)

  # Set a path for the custom archetype library path
  library_path = try(format("%s", var.enterprise_scale.library_path), "")

  # Deploys the custom landing zone configuration as defined in config file
  custom_landing_zones       = try(var.enterprise_scale.custom_landing_zones, {})
  subscription_id_overrides  = try(var.enterprise_scale.subscription_id_overrides, {})
  archetype_config_overrides = try(var.enterprise_scale.archetype_config_overrides, {})

  default_location = local.global_settings.regions[local.global_settings.default_region]
}
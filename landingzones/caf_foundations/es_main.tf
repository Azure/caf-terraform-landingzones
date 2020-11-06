
module "enterprise_scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "0.0.6-preview"

  root_parent_id = data.azurerm_client_config.current.tenant_id

  # Define a custom ID to use for the root Management Group
  # Also used as a prefix for all core Management Group IDs
  root_id = "caf"

  # Control whether to deploy the default core landing zones // default = true
  deploy_core_landing_zones = false

  # Control whether to deploy the demo landing zones // default = false
  deploy_demo_landing_zones = false

  # Set a path for the custom archetype library path
  library_path = try(format("%s%s", path.root, var.enterprise_scale.library_path), "")

  # Deploys the custom landing zone configuration as defined in config file
  custom_landing_zones = try(var.enterprise_scale.management_groups, {})

  default_location = local.global_settings.regions[local.global_settings.default_region]
}
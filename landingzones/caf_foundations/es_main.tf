
module "enterprise_scale" {
  source  = "Azure/enterprise-scale/azurerm"
  version = "0.0.2-preview"

  es_root_parent_id            = data.azurerm_client_config.current.tenant_id

  # Define a custom ID to use for the root Management Group
  # Also used as a prefix for all core Management Group IDs
  es_root_id                   = "caf"

  # Define a custom "friendly name" for the root Management Group
  es_root_name                 = "CAF Enterprise Scale"

  # Control whether to deploy the default core landing zones // default = true
  es_deploy_core_landing_zones = false

  # Control whether to deploy the demo landing zones // default = false
  es_deploy_demo_landing_zones = false

  # Set a path for the custom archetype library path
  es_archetype_library_path    = "${path.root}/es_lib"

  es_custom_landing_zones = local.es_custom_management_groups

  es_default_location = local.global_settings.regions[local.global_settings.default_region]

}
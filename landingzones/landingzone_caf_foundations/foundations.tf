## calling the blueprints
module "blueprint_foundations_accounting" {
  source = "./blueprint_foundations_accounting/"

  prefix              = local.prefix
  tags                = var.tags
  location            = var.global_settings.location_map.region1
  tags_hub            = var.global_settings.tags_hub
  resource_groups_hub = var.global_settings.resource_groups_hub
  convention          = var.global_settings.convention

  accounting_settings = var.accounting_settings
}

module "blueprint_foundations_security" {
  source = "./blueprint_foundations_security/"

  tags                = var.tags
  location            = var.global_settings.location_map.region1
  tags_hub            = var.global_settings.tags_hub
  resource_groups_hub = module.blueprint_foundations_accounting.resource_group_operations
  log_analytics       = module.blueprint_foundations_accounting.log_analytics_workspace

  security_settings = var.security_settings
}

module "blueprint_foundations_governance" {
  source = "./blueprint_foundations_governance/"

  tags          = var.tags
  tags_hub      = var.global_settings.tags_hub
  location      = var.global_settings.location_map.region1
  log_analytics = module.blueprint_foundations_accounting.log_analytics_workspace

  governance_settings = var.governance_settings
}
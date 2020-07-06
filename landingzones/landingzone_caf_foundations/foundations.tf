# calling the addons
module "foundations_accounting" {
  source = "./foundations_accounting/"

  prefix              = local.prefix
  tags                = local.tags
  location            = var.global_settings.location_map.region1
  tags_hub            = local.tags_hub
  resource_groups_hub = var.global_settings.resource_groups_hub
  convention          = var.global_settings.convention

  accounting_settings = var.accounting_settings
}

module "foundations_security" {
  source = "./foundations_security/"

  tags                = local.tags
  location            = var.global_settings.location_map.region1
  tags_hub            = local.tags_hub
  resource_groups_hub = module.foundations_accounting.resource_group_operations
  log_analytics       = module.foundations_accounting.log_analytics_workspace

  security_settings = var.security_settings
}

module "foundations_governance" {
  source = "./foundations_governance/"

  tags          = local.tags
  tags_hub      = local.tags_hub
  location      = var.global_settings.location_map.region1
  log_analytics = module.foundations_accounting.log_analytics_workspace

  governance_settings = var.governance_settings
}
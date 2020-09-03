module "foundations_accounting" {
  for_each = var.global_settings.location_map
  source   = "./foundations_accounting/"

  prefix              = local.prefix
  tags                = local.tags
  location            = each.value
  tags_hub            = local.tags_hub
  resource_groups_hub = var.global_settings.resource_groups_hub[each.key]
  convention          = var.global_settings.convention

  accounting_settings = var.accounting_settings[each.key]
}

module "foundations_security" {
  for_each = var.global_settings.location_map
  source   = "./foundations_security/"

  tags                = local.tags
  location            = each.value
  tags_hub            = local.tags_hub
  resource_groups_hub = module.foundations_accounting[each.key].resource_group_operations
  log_analytics       = module.foundations_accounting[each.key].log_analytics_workspace

  security_settings = var.security_settings
}

module "foundations_governance" {
  for_each = var.global_settings.location_map
  source   = "./foundations_governance/"

  tags          = local.tags
  tags_hub      = local.tags_hub
  location      = each.value
  log_analytics = module.foundations_accounting[each.key].log_analytics_workspace

  governance_settings = var.governance_settings[each.key]
}
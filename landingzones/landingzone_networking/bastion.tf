## Azure Bastion configuration
module "az_bastion_ip" {
  source  = "aztfmod/caf-public-ip/azurerm"
  version = "2.1.0"

  for_each = var.bastions

  convention                 = lookup(each.value, "convention", local.global_settings.convention)
  name                       = each.value.bastion_ip_addr_config.ip_name
  location                   = each.value.location
  resource_group_name        = azurerm_resource_group.rg[each.value.resource_group_key].name
  ip_addr                    = each.value.bastion_ip_addr_config
  tags                       = local.tags
  diagnostics_map            = local.caf_foundations_accounting[each.value.location].diagnostics_map
  log_analytics_workspace_id = local.caf_foundations_accounting[each.value.location].log_analytics_workspace.id
  diagnostics_settings       = each.value.bastion_ip_addr_config.diagnostics
}

module "az_bastion" {
  source  = "aztfmod/caf-azure-bastion/azurerm"
  version = "1.0.0"

  for_each = var.bastions

  bastion_config          = each.value.bastion_config
  convention              = lookup(each.value, "convention", local.global_settings.convention)
  name                    = each.value.bastion_config.name
  resource_group_name     = azurerm_resource_group.rg[each.value.resource_group_key].name
  subnet_id               = module.vnets[each.value.vnet_key].vnet_subnets[each.value.subnet_key]
  public_ip_address_id    = module.az_bastion_ip[each.key].id
  location                = each.value.location
  tags                    = local.tags
  diagnostics_map         = local.caf_foundations_accounting[each.value.location].diagnostics_map
  log_analytics_workspace = local.caf_foundations_accounting[each.value.location].log_analytics_workspace
  diagnostics_settings    = each.value.bastion_config.diagnostics
}


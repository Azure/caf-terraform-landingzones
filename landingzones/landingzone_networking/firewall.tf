
## Azure Firewall configuration
module "az_firewall_ip" {
  for_each = var.firewalls

  source = "github.com/aztfmod/terraform-azurerm-caf-public-ip?ref=vnext"
  # source  = "aztfmod/caf-public-ip/azurerm"
  # version = "2.0.0"

  convention                 = lookup(each.value, "convention", local.global_settings.convention)
  name                       = each.value.firewall_ip_addr_config.ip_name
  location                   = each.value.location
  resource_group_name        = azurerm_resource_group.rg[each.value.resource_group_key].name
  ip_addr                    = each.value.firewall_ip_addr_config
  tags                       = local.tags
  diagnostics_map            = local.caf_foundations_accounting.diagnostics_map
  log_analytics_workspace_id = local.caf_foundations_accounting.log_analytics_workspace.id
  diagnostics_settings       = each.value.firewall_ip_addr_config.diagnostics
}

module "az_firewall" {
  for_each = var.firewalls

  source = "github.com/aztfmod/terraform-azurerm-caf-azure-firewall?ref=vnext"
  # source  = "aztfmod/caf-azure-firewall/azurerm"
  # version = "2.0.0"

  convention           = lookup(each.value, "convention", local.global_settings.convention)
  name                 = each.value.az_fw_config.name
  resource_group_name  = azurerm_resource_group.rg[each.value.resource_group_key].name
  subnet_id            = module.vnets[each.value.vnet_key].vnet_subnets["AzureFirewallSubnet"]
  public_ip_id         = module.az_firewall_ip[each.key].id
  location             = each.value.location
  tags                 = local.tags
  diagnostics_map      = local.caf_foundations_accounting.diagnostics_map
  la_workspace_id      = local.caf_foundations_accounting.log_analytics_workspace.id
  diagnostics_settings = each.value.az_fw_config.diagnostics
}

module "firewall_dashboard" {
  for_each = var.firewalls

  source = "./modules/firewall_dashboard"

  fw_id    = module.az_firewall[each.key].id
  pip_id   = module.az_firewall_ip[each.key].id
  location = each.value.location
  rg       = azurerm_resource_group.rg[each.value.resource_group_key].name
  name     = "${local.prefix_with_hyphen}${basename(abspath(path.module))}"
  tags     = local.tags
}

# TODO: need improvements to put rules in the config file
module "firewall_rules" {
  for_each = var.firewalls

  source = "./modules/firewall_rules"

  az_firewall_settings = module.az_firewall[each.key].az_firewall_config
}
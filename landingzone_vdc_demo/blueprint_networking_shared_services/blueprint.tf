module "resource_group_shared_services" {
  source  = "aztfmod/caf-resource-group/azurerm"
  version = "0.1.1"

  prefix          = var.prefix
  resource_groups = var.resource_groups_shared_services
  tags            = local.tags
}

module "networking_shared_services" {
  source  = "aztfmod/caf-virtual-network/azurerm"
  version = "0.1.0"

  virtual_network_rg                = lookup(module.resource_group_shared_services.names, "HUB-CORE-NET", null)
  prefix                            = var.prefix
  location                          = var.location["region1"]
  networking_object                 = var.shared_services_vnet
  tags                              = local.tags
  diagnostics_map                   = var.diagnostics_map
  log_analytics_workspace           = var.log_analytics_workspace
}

module "ddos_protection_std" {
  source = "./ddos_protection"

  enable_ddos_standard              = var.enable_ddos_standard
  name                              = var.ddos_name
  rg                                = lookup(module.resource_group_shared_services.names, "HUB-CORE-NET", null)
  location                          = var.location["region1"] 
  tags                              = local.tags
}
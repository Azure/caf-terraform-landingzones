module "resource_group" {
  source  = "aztfmod/caf-resource-group/azurerm"
  version = "0.1.1"

  prefix          = var.prefix
  resource_groups = var.resource_groups_shared_services
  tags            = local.tags
}

locals {
  HUB-CORE-NET = lookup(module.resource_group.names, "HUB-CORE-NET", null)
}

module "networking_shared_services" {
  source  = "aztfmod/caf-virtual-network/azurerm"
  version = "2.0.0"

  convention                        = var.global_settings.convention
  resource_group_name               = local.HUB-CORE-NET
  prefix                            = var.prefix
  location                          = var.location
  networking_object                 = var.shared_services_vnet
  tags                              = local.tags
  diagnostics_map                   = var.diagnostics_map
  log_analytics_workspace           = var.log_analytics_workspace
  diagnostics_settings              = var.shared_services_vnet.diagnostics
}

module "ddos_protection_std" {
  source = "./ddos_protection"

  enable_ddos_standard              = var.enable_ddos_standard
  name                              = var.ddos_name
  rg                                = local.HUB-CORE-NET
  location                          = var.location
  tags                              = local.tags
}

# # Azure Bastion is only available GA in few regions for 1911 release, 
# # please check https://azure.microsoft.com/en-us/global-infrastructure/services/?products=azure-bastion 
# module "bastion_host" {
#   source = "./bastion"

#   enable_bastion                    = var.enable_bastion
#   name                              = var.bastion_config.name
#   rg                                = local.HUB-CORE-NET
#   subnet_id                         = module.networking_shared_services.vnet_subnets["AzureBastionSubnet"]
#   location                          = var.location 
#   tags                              = local.tags
#   diagnostics_map                   = var.diagnostics_map
#   log_analytics_workspace_id        = var.log_analytics_workspace.id
#   ip_name                           = var.bastion_config.ip_name
#   ip_addr                           = var.bastion_config.ip_addr
#   ip_diags                          = var.bastion_config.ip_diags
#   diagnostics_settings              = var.bastion_config.diagnostics
# }
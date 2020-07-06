resource "azurecaf_naming_convention" "rg_network_shared" {
  name          = var.resource_groups_shared_services.HUB-CORE-NET.name
  prefix        = var.prefix != "" ? var.prefix : null
  resource_type = "azurerm_resource_group"
  convention    = var.global_settings.convention
}

resource "azurerm_resource_group" "rg_network_shared" {
  name     = azurecaf_naming_convention.rg_network_shared.result
  location = var.resource_groups_shared_services.HUB-CORE-NET.location
  tags     = local.tags
}

module "networking_shared_services" {
  source = "github.com/aztfmod/terraform-azurerm-caf-virtual-network?ref=vnext"
  # source  = "aztfmod/caf-virtual-network/azurerm"
  # version = "3.0.0"

  convention              = var.global_settings.convention
  resource_group_name     = azurerm_resource_group.rg_network_shared.name
  prefix                  = var.prefix
  location                = var.location
  networking_object       = var.shared_services_vnet
  tags                    = local.tags
  diagnostics_map         = var.diagnostics_map
  log_analytics_workspace = var.log_analytics_workspace
  diagnostics_settings    = var.shared_services_vnet.diagnostics
}

module "ddos_protection_std" {
  source = "./ddos_protection"

  enable_ddos_standard = var.enable_ddos_standard
  name                 = var.ddos_name
  rg                   = azurerm_resource_group.rg_network_shared.name
  location             = var.location
  tags                 = local.tags
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
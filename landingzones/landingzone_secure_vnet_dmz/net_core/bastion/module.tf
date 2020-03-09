module "bastion_pip" {
  source  = "aztfmod/caf-public-ip/azurerm"
  version = "1.0.0"

  convention                       = var.global_settings.convention 
  name                             = var.bastion_config.ip_name
  location                         = var.location
  rg                               = var.rg
  ip_addr                          = var.bastion_config.ip_addr
  tags                             = var.tags
  diagnostics_map                  = var.caf_foundations_accounting.diagnostics_map
  log_analytics_workspace_id       = var.caf_foundations_accounting.log_analytics_workspace.id
  diagnostics_settings             = var.bastion_config.ip_diags
}

resource "azurerm_bastion_host" "azurebastion" {

  name                = var.bastion_config.name
  location            = var.location
  resource_group_name = var.rg
  tags                = var.tags

  ip_configuration {
    name                 = "bastionpipconfiguration"
    subnet_id            = var.subnet_id
    public_ip_address_id = module.bastion_pip.id
  }
}

module "diagnostics_bastion" {
  source  = "aztfmod/caf-diagnostics/azurerm"
  version = "1.0.0"

    name                            = azurerm_bastion_host.azurebastion.name
    resource_id                     = azurerm_bastion_host.azurebastion.id
    log_analytics_workspace_id      = var.caf_foundations_accounting.log_analytics_workspace.id
    diagnostics_map                 = var.caf_foundations_accounting.diagnostics_map
    diag_object                     = var.bastion_config.diagnostics
}
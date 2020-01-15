module "bastion_pip" {
  source  = "aztfmod/caf-public-ip/azurerm"
  version = "0.1.3"

  name                             = var.ip_name
  location                         = var.location
  rg                               = var.rg
  ip_addr                          = var.ip_addr
  tags                             = var.tags
  diagnostics_map                  = var.diagnostics_map
  log_analytics_workspace_id       = var.log_analytics_workspace_id
  diagnostics_settings             = var.ip_diags
}

resource "azurerm_bastion_host" "azurebastion" {

  name                = var.name
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
  version = "0.1.1"

    name                            = azurerm_bastion_host.azurebastion.name
    resource_id                     = azurerm_bastion_host.azurebastion.id
    log_analytics_workspace_id      = var.log_analytics_workspace_id
    diagnostics_map                 = var.diagnostics_map
    diag_object                     = var.diagnostics_settings
}
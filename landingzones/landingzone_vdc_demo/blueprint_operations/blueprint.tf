#Specify the Azure Site Recovery repository
module "site_recovery" {
  source  = "aztfmod/caf-site-recovery/azurerm"
  version = "0.1.2"
  
  asr_vault_name           = var.asr_vault_name
  resource_group_name      = var.asr_rg
  location                 = var.location 
  tags                     = var.tags
  la_workspace_id          = var.log_analytics_workspace.id
  diagnostics_map          = var.diagnostics_map
  diagnostics_settings     = var.asr_diags
}

#Creates the Azure automation account
module "automation" {
  source  = "aztfmod/caf-automation/azurerm"
  version = "0.1.2"

  auto_name               = var.auto_account
  resource_group_name     = var.auto_rg
  location                = var.location
  tags                    = var.tags
  la_workspace_id         = var.log_analytics_workspace.id
  diagnostics_map         = var.diagnostics_map
  diagnostics_settings    = var.auto_diags
}
#Specify the Azure Site Recovery repository
module "site_recovery" {
  source  = "aztfmod/caf-site-recovery/azurerm"
  # version = "2.0.0"
  version = "1.0.0"
  
  convention               = var.global_settings.convention
  name                     = var.asr_config.asr_vault_name
  rg                       = var.asr_rg
 # resource_group_name      = var.asr_rg
  location                 = var.location 
  tags                     = var.global_settings.tags_hub
  la_workspace_id          = var.caf_foundations_accounting.log_analytics_workspace.id
  diagnostics_map          = var.caf_foundations_accounting.diagnostics_map
  diagnostics_settings     = var.asr_config.asr_diags
}

#Creates the Azure automation account
module "automation" {
  source  = "aztfmod/caf-automation/azurerm"
  version = "1.0.0"
  # version = "2.0.0"
  convention              = var.global_settings.convention
  name                    = var.auto_config.auto_account
  rg                      = var.auto_rg
  # resource_group_name      = var.asr_rg
  location                = var.location
  tags                    = var.global_settings.tags_hub
  la_workspace_id         = var.caf_foundations_accounting.log_analytics_workspace.id
  diagnostics_map         = var.caf_foundations_accounting.diagnostics_map
  diagnostics_settings    = var.auto_config.auto_diags
}
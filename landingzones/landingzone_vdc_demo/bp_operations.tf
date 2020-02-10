 module "blueprint_operations" {
     source = "./blueprint_operations"
  
    prefix                             = local.prefix
    location                           = local.global_settings.location_map["region1"]
    log_analytics_workspace            = local.caf_foundations_accounting.log_analytics_workspace
    diagnostics_map                    = local.caf_foundations_accounting.diagnostics_map
    tags                               = local.global_settings.tags_hub

    resource_groups_operations         = lookup(local.caf_foundations_accounting.resource_group_hub_names, "HUB-OPERATIONS", null)
    asr_rg                             = lookup(local.caf_foundations_accounting.resource_group_hub_names, "HUB-OPERATIONS", null)  
    auto_rg                            = lookup(local.caf_foundations_accounting.resource_group_hub_names, "HUB-OPERATIONS", null)
    
    asr_vault_name                     = var.asr_config.asr_vault_name
    asr_diags                          = var.asr_config.asr_diags
    auto_diags                         = var.auto_config.auto_diags
    auto_account                       = var.auto_config.auto_account
}
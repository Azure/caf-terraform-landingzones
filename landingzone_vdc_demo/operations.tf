 module "blueprint_operations" {
     source = "./blueprint_operations"
  

    asr_vault_name                     = var.asr_vault_name
    asr_diags                          = var.asr_diags
    auto_diags                         = var.auto_diags
    auto_account                       = var.auto_account

    resource_groups_operations         = module.blueprint_tranquility.resource_group_hub_names["HUB-OPERATIONS"]
    asr_rg                             = module.blueprint_tranquility.resource_group_hub_names["HUB-OPERATIONS"]   
    auto_rg                            = module.blueprint_tranquility.resource_group_hub_names["HUB-OPERATIONS"]
    
    location                           = module.blueprint_tranquility.location_map["region1"]
    log_analytics_workspace            = module.blueprint_tranquility.log_analytics_workspace
    diagnostics_map                    = module.blueprint_tranquility.diagnostics_map
    tags                               = module.blueprint_tranquility.tags
    prefix                             = module.blueprint_tranquility.prefix
}
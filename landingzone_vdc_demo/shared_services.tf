 module "blueprint_operations" {
     source = "github.com/aztfmod/blueprints?ref=1911/blueprint_shared_services"
  

    asr_vault_name                     = var.asr_vault_name
    asr_diags                          = var.asr_diags
    auto_diags                         = var.auto_diags
    auto_account                       = var.auto_account

    resource_groups_operations         = lookup(module.blueprint_foundations.resource_group_hub_names, "HUB-OPERATIONS", null)
    asr_rg                             = lookup(module.blueprint_foundations.resource_group_hub_names, "HUB-OPERATIONS", null)  
    auto_rg                            = lookup(module.blueprint_foundations.resource_group_hub_names, "HUB-OPERATIONS", null)
    
    location                           = var.location_map["region1"]
    log_analytics_workspace            = module.blueprint_foundations.log_analytics_workspace
    diagnostics_map                    = module.blueprint_foundations.diagnostics_map
    tags                               = module.blueprint_foundations.tags
    prefix                             = module.blueprint_foundations.prefix
}
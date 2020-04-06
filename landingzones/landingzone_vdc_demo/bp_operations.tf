 module "blueprint_operations" {
     source = "./blueprint_operations"
  
    prefix                             = local.prefix
    location                           = local.global_settings.location_map["region1"]
    caf_foundations_accounting         = local.caf_foundations_accounting
    global_settings                    = local.global_settings

    resource_groups_operations         = lookup(local.caf_foundations_accounting.resource_group_operations, "name", null)
    asr_rg                             = lookup(local.caf_foundations_accounting.resource_group_operations, "name", null)  
    auto_rg                            = lookup(local.caf_foundations_accounting.resource_group_operations, "name", null)
    
    asr_config                         = var.asr_config
    auto_config                        = var.auto_config
}
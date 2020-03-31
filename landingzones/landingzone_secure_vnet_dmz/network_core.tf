module "net_core" {
    source = "./net_core"
  
    global_settings                     = local.global_settings
    prefix                              = local.prefix
    location                            = local.global_settings.location_map["region1"]
    caf_foundations_accounting          = local.caf_foundations_accounting
    core_networking                     = var.core_networking
    rg_network                          = var.rg_network
    logged_user_objectId                = var.logged_user_objectId
}

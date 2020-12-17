
module dynamic_keyvault_secrets {
  source  = "aztfmod/caf/azurerm//modules/security/dynamic_keyvault_secrets"
  version = "~>4.21"

  for_each = try(var.dynamic_keyvault_secrets, {})

  settings    = each.value
  keyvault    = module.foundations.keyvaults[each.key]
  objects     = module.foundations
}

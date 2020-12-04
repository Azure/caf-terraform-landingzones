
module dynamic_keyvault_secrets {
  source  = "aztfmod/caf/azurerm//modules/security/dynamic_keyvault_secrets"
  version = "~> 0.4"

  for_each = try(var.dynamic_keyvault_secrets, {})

  settings    = each.value
  keyvault_id = module.foundations.keyvaults[each.key].id
  objects     = module.foundations
}

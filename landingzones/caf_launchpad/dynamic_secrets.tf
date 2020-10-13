
module dynamic_keyvault_secrets {
  source   = "./dynamic_keyvault_secrets"
  for_each = try(var.dynamic_keyvault_secrets, {})

  settings    = each.value
  keyvault_id = module.launchpad.keyvaults[each.key].id
  objects     = module.launchpad
}

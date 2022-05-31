
module "dynamic_keyvault_secrets" {
  source = "../aztfmod/modules/security/dynamic_keyvault_secrets"

  for_each = try(var.dynamic_keyvault_secrets, {})

  settings = each.value
  keyvault = module.launchpad.keyvaults[each.key]
  objects  = module.launchpad
}

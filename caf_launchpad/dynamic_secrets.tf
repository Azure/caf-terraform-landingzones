
module "dynamic_keyvault_secrets" {
  source  = "aztfmod/caf/azurerm//modules/security/dynamic_keyvault_secrets"
  version = "5.7.2"

  for_each = try(var.dynamic_keyvault_secrets, {})

  settings = each.value
  keyvault = module.launchpad.keyvaults[each.key]
  objects  = module.launchpad
}

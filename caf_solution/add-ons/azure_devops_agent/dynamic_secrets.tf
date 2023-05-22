
module "dynamic_keyvault_secrets" {
  source  = "aztfmod/caf/azurerm//modules/security/dynamic_keyvault_secrets"
  version = "~>5.6.8"
  # source = "git::https://github.com/aztfmod/terraform-azurerm-caf.git//modules/security/dynamic_keyvault_secrets?ref=master"


  for_each = try(var.dynamic_keyvault_secrets, {})

  settings = each.value
  keyvault = module.caf.keyvaults[each.key]
  objects  = module.caf
}

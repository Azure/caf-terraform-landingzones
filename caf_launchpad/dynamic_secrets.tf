
module "dynamic_keyvault_secrets" {
  # source  = "aztfmod/caf/azurerm//modules/security/dynamic_keyvault_secrets"
  # version = "5.5.5"

  source = "git::https://github.com/aztfmod/terraform-azurerm-caf.git//modules/security/dynamic_keyvault_secrets?ref=main"

  for_each = try(var.dynamic_keyvault_secrets, {})

  settings = each.value
  keyvault = module.launchpad.keyvaults[each.key]
  objects  = module.launchpad
}

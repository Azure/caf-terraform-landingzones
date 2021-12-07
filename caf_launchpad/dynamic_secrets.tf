
module "dynamic_keyvault_secrets" {
  # source  = "aztfmod/caf/azurerm//modules/security/dynamic_keyvault_secrets"
  # version = "~>5.4.2"

  source = "git::https://github.com/aztfmod/terraform-azurerm-caf.git//modules/security/dynamic_keyvault_secrets?ref=p.remote_rg"

  for_each = try(var.dynamic_keyvault_secrets, {})

  settings = each.value
  keyvault = module.launchpad.keyvaults[each.key]
  objects  = module.launchpad
}

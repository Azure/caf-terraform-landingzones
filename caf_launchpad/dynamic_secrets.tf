
module "dynamic_keyvault_secrets" {
  # source  = "aztfmod/caf/azurerm"
  # version = "5.7.0"
  source = "git::https://github.com/aztfmod/terraform-azurerm-caf.git?ref=main"

  for_each = try(var.dynamic_keyvault_secrets, {})

  settings = each.value
  keyvault = module.launchpad.keyvaults[each.key]
  objects  = module.launchpad
}

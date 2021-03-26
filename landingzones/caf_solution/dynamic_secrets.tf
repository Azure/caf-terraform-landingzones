module "dynamic_keyvault_secrets" {
  source  = "aztfmod/caf/azurerm//modules/security/dynamic_keyvault_secrets"
  version = "5.3.0-preview2"

  for_each = try(var.dynamic_keyvault_secrets, {})

  settings = each.value
  keyvault = module.solution.keyvaults[each.key]
  objects  = module.solution
}
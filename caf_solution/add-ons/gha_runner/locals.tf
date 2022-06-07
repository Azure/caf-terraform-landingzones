locals {
  azuread = merge(
    var.azuread,
    {
      azuread_apps   = var.azuread_apps
      azuread_groups = var.azuread_groups
    }
  )

  security = merge(
    var.security,
    {
      dynamic_keyvault_secret = var.dynamic_keyvault_secrets
    }
  )
}

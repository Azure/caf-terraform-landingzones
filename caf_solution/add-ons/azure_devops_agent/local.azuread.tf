locals {
  azuread = merge(
    var.azuread,
    {
      azuread_apps   = var.azuread_apps
      azuread_groups = var.azuread_groups
    }
  )
}

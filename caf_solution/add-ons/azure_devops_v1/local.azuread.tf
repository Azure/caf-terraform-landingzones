locals {
  azuread = merge(
    var.azuread,
    {
      azuread_applications                = var.azuread_applications
      azuread_service_principals          = var.azuread_service_principals
      azuread_service_principal_passwords = var.azuread_service_principal_passwords
    }
  )
}

locals {
  azuread = merge(
    var.azuread,
    {
    azuread_api_permissions             = var.azuread_api_permissions
    azuread_applications                = var.azuread_applications
    azuread_apps                        = var.azuread_apps
    azuread_groups                      = var.azuread_groups
    azuread_password_policies           = var.azuread_password_policies
    azuread_roles                       = var.azuread_roles
    azuread_service_principal_passwords = var.azuread_service_principal_passwords
    azuread_service_principals          = var.azuread_service_principals
    azuread_users                       = var.azuread_users
    }
  )
}

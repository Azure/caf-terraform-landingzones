locals {
  azuread = merge(
    var.azuread,
    {
      azuread_administrative_unit_members = var.azuread_administrative_unit_members
      azuread_administrative_units        = var.azuread_administrative_units
      azuread_api_permissions             = var.azuread_api_permissions
      azuread_applications                = var.azuread_applications
      azuread_apps                        = var.azuread_apps
      azuread_conditional_access          = var.azuread_conditional_access
      azuread_credential_policies         = var.azuread_credential_policies
      azuread_credentials                 = var.azuread_credentials
      azuread_groups                      = var.azuread_groups
      azuread_groups_membership           = var.azuread_groups_membership
      azuread_roles                       = var.azuread_roles
      azuread_service_principal_passwords = var.azuread_service_principal_passwords
      azuread_service_principals          = var.azuread_service_principals
      azuread_users                       = var.azuread_users
    }
  )
}

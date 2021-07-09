resource "vault_azure_secret_backend" "azuresp" {
  path            = var.settings.backend
  subscription_id = "7e01ba9c-ef41-4252-92e7-5716d7995ad2"
  tenant_id       = "3217d691-edcd-490d-b5ec-dc724087b782"
  client_id       = "9c355896-bab8-4412-b850-700a9d69ca4c"
  client_secret   = "1CMihRG0esN2Ow68rMhiyBI8OrHKqkghzvHOFOyJuDZN6JPSY5USTL6mMvWuUlPTeOP18dRayf4EPJp5odCIspiosWMXi1yIuxPM6jhQnbMyXZPbrNIWByQBSIJDeY9oVFA7zxAsO7sWos19Tf4lS59qwFJOdQ7cgOhJQ6a5J5A8DNyajOXIFPbd3Y7VgYUlDfJbnf59JkryvI1nZLQ2Kej2TDJxOBtRMetfEDckqwxYElrbEeIgwny9JX"
  # environment     = "AzurePublicCloud"
}

resource "vault_azure_secret_backend_role" "existing_object_id" {

  backend               = vault_azure_secret_backend.azuresp.path
  role                  = var.settings.role
  application_object_id = var.objects[var.settings.azuread_application.lz_key][var.settings.azuread_application.output_key][var.settings.azuread_application.resource_key][var.settings.azuread_application.attribute_key]
  ttl                   = try(var.settings.ttl, null)
  max_ttl               = try(var.settings.max_ttl, null)
}

resource "vault_azure_secret_backend_role" "existing_object_id" {

  backend               = var.settings.backend
  role                  = var.settings.role
  application_object_id = var.objects[var.settings.azuread_application.lz_key][var.settings.azuread_application.output_key][var.settings.azuread_application.resource_key][var.settings.azuread_application.attribute_key]
  ttl                   = try(var.settings.ttl, null)
  max_ttl               = try(var.settings.max_ttl, null)
}

resource "vault_azure_secret_backend_role" "existing_object_id" {

  backend               = var.settings.backend
  role                  = var.settings.role
  # application_object_id = var.objects[var.settings.azuread_application.lz_key][var.settings.azuread_application.output_key][var.settings.azuread_application.resource_key][var.settings.azuread_application.attribute_key]
  # application_object_id = "614dffd5-72e8-4c17-949c-fd4a934706d2"
  application_object_id = "354fbdf7-0fc7-4131-afdc-05de707cd212" # sp object id
  ttl                   = try(var.settings.ttl, null)
  max_ttl               = try(var.settings.max_ttl, null)
}
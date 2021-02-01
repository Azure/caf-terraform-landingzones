# The PAT token must be provisioned in a different deployment
provider "azuredevops" {
  org_service_url       = var.azure_devops.url
  personal_access_token = data.azurerm_key_vault_secret.pat.value
}

data "azurerm_key_vault_secret" "pat" {
  name         = var.azure_devops.pats["admin"].secret_name
  key_vault_id = local.remote.keyvaults[var.azure_devops.pats["admin"].lz_key][var.azure_devops.pats["admin"].keyvault_key].id

}

data "azuredevops_project" "project" {
  name = var.azure_devops.project
}
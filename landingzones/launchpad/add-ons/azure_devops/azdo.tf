terraform {
  experiments = [variable_validation]
  
  required_providers {
    azurerm = "~> 2.20.0"
  }
}

provider "azurerm" {
  features {}
}



provider "azuredevops" {
  org_service_url       = var.azure_devops.organization_url
  personal_access_token = data.azurerm_key_vault_secret.pat.value
}

data "azurerm_key_vault_secret" "pat" {
  name         = var.azure_devops.pats[var.launchpad_key_names.azure_devops_management_pat].secret_name
  key_vault_id = local.keyvaults[var.launchpad_key_names.keyvault].id
}

data "azuredevops_project" "project" {
  project_name = var.azure_devops.project
}
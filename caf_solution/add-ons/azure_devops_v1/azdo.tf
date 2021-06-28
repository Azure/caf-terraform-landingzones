# The PAT token must be provisioned in a different deployment
provider "azuredevops" {
  org_service_url       = var.azure_devops.url
  personal_access_token = var.azdo_pat_admin == null ? data.external.pat[0].result.value : var.azdo_pat_admin
}

# To support cross subscrpition reference
data "external" "pat" {
  count = var.azdo_pat_admin == null ? 1 : 0
  program = [
    "bash", "-c",
    format(
      "az keyvault secret show --id '%s'secrets/'%s' --query '{value: value}' -o json",
      local.remote.keyvaults[var.azure_devops.pats["admin"].lz_key][var.azure_devops.pats["admin"].keyvault_key].vault_uri,
      var.azure_devops.pats["admin"].secret_name
    )
  ]
}

# To support cross subscription
data "external" "github_pat" {
  for_each = {
    for key, value in var.service_endpoints : key => value
    if try(value.type, null) == "Github"
  }

  program = [
    "bash", "-c",
    format(
      "az keyvault secret show --id '%s'secrets/'%s' --query '{value: value}' -o json",
      local.remote.keyvaults[each.value.keyvault.lz_key][each.value.keyvault.key].vault_uri,
      each.value.keyvault.secret_name
    )
  ]
}

resource "azuredevops_serviceendpoint_github" "serviceendpoint_github" {
  for_each = {
    for key, value in var.service_endpoints : key => value
    if try(value.type, null) == "Github"
  }

  project_id            = data.azuredevops_project.project[each.value.project_key].id
  service_endpoint_name = each.value.endpoint_name

  auth_personal {
    personal_access_token = data.external.github_pat[each.key].result.value
  }
}

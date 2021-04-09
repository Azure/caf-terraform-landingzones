data "azuredevops_git_repositories" "repos" {
  project_id = data.azuredevops_project.project.id
}


locals {
  repositories = zipmap(tolist(data.azuredevops_git_repositories.repos.repositories.*.name), tolist(data.azuredevops_git_repositories.repos.repositories))
}

resource "azuredevops_build_definition" "build_definition" {

  for_each   = try(var.azure_devops.pipelines, {})
  project_id = data.azuredevops_project.project.id
  name       = each.value.name
  path       = each.value.folder

  variable_groups = lookup(each.value, "variable_group_keys", null) == null ? null : [
    for key in each.value.variable_group_keys :
    azuredevops_variable_group.variable_group[key].id
  ]

  repository {
    repo_id     = local.repositories[each.value.git_repo_name].id
    repo_type   = each.value.repo_type
    yml_path    = each.value.yaml
    branch_name = lookup(each.value, "branch_name", null)
    # service_connection_id = lookup(each.value, "repo_type", null) == "github" ? null : azuredevops_serviceendpoint_azurerm.github[each.value.service_connection_key].id
  }

  ci_trigger {
    use_yaml = true
  }

  dynamic "variable" {
    for_each = try(each.value.variables, {})

    content {
      name  = variable.key
      value = variable.value
    }
  }

}

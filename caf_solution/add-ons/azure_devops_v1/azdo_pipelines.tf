data "azuredevops_git_repositories" "repos" {
  for_each = var.projects

  project_id = data.azuredevops_project.project[each.key].id
}

resource "azuredevops_build_definition" "build_definition" {
  for_each = var.pipelines

  project_id = data.azuredevops_project.project[each.value.project_key].id
  name       = each.value.name
  path       = each.value.folder

  variable_groups = lookup(each.value, "variable_group_keys", null) == null ? null : [
    for key in each.value.variable_group_keys :
    azuredevops_variable_group.variable_group[key].id
  ]

  # This block handles repos that are hosted in AZDO
  dynamic "repository" {
    for_each = {
      for key, value in try(data.azuredevops_git_repositories.repos[try(each.value.repo_project_key, each.value.project_key)].repositories, {}) : key => value
      if value.name == try(each.value.git_repo_name, "")
    }

    content {
      repo_id     = repository.value.id
      repo_type   = each.value.repo_type
      yml_path    = each.value.yaml
      branch_name = lookup(each.value, "branch_name", null)
    }
  }

  # This block handles repos that are created by terraform
  dynamic "repository" {
    for_each = can(each.value.repository) ? [each.value.repository] : []

    content {
      repo_id     = module.git_repositories[repository.value.git_repository.key].id
      repo_type   = repository.value.repo_type
      yml_path    = can(repository.value.yaml) ? repository.value.yaml : repository.value.yml_path
      branch_name = try(repository.value.branch_name, module.git_repositories[repository.value.git_repository.key].default_branch)
    }
  }

  # This block handles repos that are hosted in GitHub and require a service connection
  dynamic "repository" {
    for_each = try(each.value.repo_type, null) == "GitHub" ? [1] : []

    content {
      repo_id     = each.value.git_repo_name
      repo_type   = each.value.repo_type
      yml_path    = each.value.yaml
      branch_name = lookup(each.value, "branch_name", null)
      service_connection_id = azuredevops_serviceendpoint_github.serviceendpoint_github[
      each.value.service_connection_key].id
    }
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

  dynamic "variable" {
    for_each = try(each.value.variables_objects, {})

    content {
      name  = variable.key
      value = jsonencode(variable.value)
    }
  }

}

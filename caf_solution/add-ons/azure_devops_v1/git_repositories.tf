module "git_repositories" {
  source = "./git_repository"

  for_each = var.git_repositories

  settings = each.value

  project_id           = data.azuredevops_project.project[each.value.project.key].id
  parent_repository_id = can(each.value.parent_repository_id) ? each.value.parent_repository_id : null

}
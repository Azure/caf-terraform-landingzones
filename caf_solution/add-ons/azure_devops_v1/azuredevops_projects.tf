resource "azuredevops_project" "project" {
  for_each = {
    for key, value in var.projects : key => value
    if try(value.create, false)
  }

  name               = each.value.name
  description        = each.value.description
  visibility         = try(lower(each.value.visibility), null)
  version_control    = try(each.value.version_control, null)
  work_item_template = try(each.value.work_item_template, null)
}


data "azuredevops_project" "project" {
  depends_on = [azuredevops_project.project]

  for_each = var.projects

  name = each.value.name
}

resource "azuredevops_project_features" "project" {
  for_each = {
    for key, value in var.projects : key => value
    if try(value.features, null) != null
  }

  project_id = data.azuredevops_project.project[each.key].id

  features = {
    "artifacts"    = try(lower(each.value.features.artifacts), "disabled")
    "boards"       = try(lower(each.value.features.boards), "disabled")
    "pipelines"    = try(lower(each.value.features.pipelines), "disabled")
    "repositories" = try(lower(each.value.features.repositories), "disabled")
    "testplans"    = try(lower(each.value.features.testplans), "disabled")
  }
}
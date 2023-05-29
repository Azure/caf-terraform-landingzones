resource "azuredevops_git_repository" "git" {
  name           = var.settings.name
  default_branch = try(var.settings.default_branch, null)

  project_id           = var.project_id
  parent_repository_id = var.parent_repository_id

  initialization {
    init_type   = var.settings.initialization.init_type
    source_type = var.settings.initialization.source_type
    source_url  = var.settings.initialization.source_url
  }

  lifecycle {
    precondition {
      condition     = contains(["Uninitialized", "Clean", "Import"], var.settings.initialization.init_type)
      error_message = format("Enter a valid value for method: Uninitialized, Clean or Import - Got: %s", var.settings.initialization.init_type)
    }
    precondition {
      condition     = try(var.settings.initialization.init_type, null) == "Import" ? contains(["Git"], var.settings.initialization.source_type) : true
      error_message = format("Enter a valid value for method: Git - Got: %s", var.settings.initialization.source_type)
    }
  }
}
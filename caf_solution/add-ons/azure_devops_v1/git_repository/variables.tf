variable "project_id" {
  description = "(Required) The project ID or project name."
  type        = string
}
variable "parent_repository_id" {
  description = "(Optional) The ID of a Git project from which a fork is to be created."
  type        = string
}
variable "settings" {
  description = "(Required) git_repositories map."
  default     = {}

  validation {
    condition = alltrue(
      [
        for k in keys(var.settings) : contains(
          [
            "default_branch",
            "initialization",
            "name",
            "parent_repository_id",
            "project_id",
            "project"
          ], k
        )
      ]
    )
    error_message = format("The following attributes are not supported. Adjust your configuration file in var.git_repositories: %s",
      join(", ",
        setsubtract(
          keys(var.settings),
          [
            "default_branch",
            "initialization",
            "name",
            "parent_repository_id",
            "project_id",
            "project"
          ]
        )
      )
    )
  }
}
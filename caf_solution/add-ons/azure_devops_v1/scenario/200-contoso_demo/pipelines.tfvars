pipelines = {
  launchpad = {
    project_key      = "contoso_demo"
    repo_project_key = "contoso_demo"
    name             = "launchpad"
    folder           = "\\configuration\\level0"
    yaml             = "launchpad.yml"
    repo_type        = "TfsGit"
    git_repo_name    = "contoso_demo"
    branch_name      = "main"
    variables = {
      LANDINGZONE_PATH = "caf_launchpad"
      CONFIG_PATH      = "contoso_demo/level0/launchpad"
      TFSTATE_NAME     = "caf_launchpad.tfstate"
      SAS_TOKEN        = ""
      DESTROY_FLAG     = false
    }
    variable_group_keys = ["level0"] # ["level0", "level0_client_id", "level0_client_secret"]
  }
}
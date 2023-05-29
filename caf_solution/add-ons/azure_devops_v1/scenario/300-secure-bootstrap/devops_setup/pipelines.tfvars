pipelines = {
  contoso-tfe = {
    name        = "contoso-tfe"
    project_key = "contoso"
    folder      = "\\configuration\\level0"

    repository = {
      git_repository = {
        key = "landingzone"
      }
      yml_path    = "caf_solution/add-ons/azure_devops_v1/scenario/200-contoso_demo/pipeline/rover.yaml"
      repo_type   = "TfsGit"
      branch_name = "main"
    }

    variables = {
      LANDINGZONE_PATH = "caf_launchpad"
      CONFIG_PATH      = "/tf/caf/platform/configuration/level0/launchpad"
      TFSTATE_NAME     = "caf_launchpad.tfstate"
      SAS_TOKEN        = ""
      DESTROY_FLAG     = false
    }
    variable_group_keys = ["level0"] # ["level0", "level0_client_id", "level0_client_secret"]
  }
}
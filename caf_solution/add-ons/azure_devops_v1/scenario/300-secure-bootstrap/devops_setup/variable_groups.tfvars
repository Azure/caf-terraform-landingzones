variable_groups = {
  global = {
    project_key  = "contoso"
    name         = "release-global" # changing that name requires to change it in the devops agents yaml variables group
    allow_access = true
    variables = {
      HOME_FOLDER_USER    = "vscode"
      ROVER_IMAGE         = "aztfmod/rover-agent:1.4.6-2305.1807-azdo"
      TF_CLI_ARGS         = "'-no-color'"
      TF_CLI_ARGS_init    = ""
      TF_CLI_ARGS_plan    = "'-input=false'"
      TF_VAR_ARGS_destroy = "'-auto-approve -refresh=false'"
      ENVIRONMENT         = "contoso"
      LANDINGZONE_BRANCH  = "azdo.update"
      ROVER_RUNNER        = "true"
      ARM_USE_AZUREAD     = "true"
    }
  }

  level0 = {
    project_key  = "contoso"
    name         = "release-level0"
    allow_access = true
    variables = {
      PIPELINE_LEVEL = "level0"
      ARM_USE_MSI    = "true"
      AGENT_POOL     = "contoso-level0"
    }
  }

  level1 = {
    project_key  = "contoso"
    name         = "release-level1"
    allow_access = true
    variables = {
      PIPELINE_LEVEL = "level1"
      ARM_USE_MSI    = "true"
      AGENT_POOL     = "contoso-level1"
    }
  }

  level2 = {
    project_key  = "contoso"
    name         = "release-level2"
    allow_access = true
    variables = {
      PIPELINE_LEVEL = "level2"
      ARM_USE_MSI    = "true"
      AGENT_POOL     = "contoso-level2"
    }
  }

}
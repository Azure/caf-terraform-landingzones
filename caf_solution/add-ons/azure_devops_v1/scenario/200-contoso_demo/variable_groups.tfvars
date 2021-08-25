variable_groups = {
  global = {
    project_key  = "contoso_demo"
    name         = "release-global" # changing that name requires to change it in the devops agents yaml variables group
    allow_access = true
    variables = {
      HOME_FOLDER_USER    = "vsts_azpcontainer"
      ROVER_IMAGE         = "aztfmod/rover:0.15.4-2105.2603"
      TF_CLI_ARGS         = "'-no-color'"
      TF_CLI_ARGS_init    = ""
      TF_CLI_ARGS_plan    = "'-input=false'"
      TF_VAR_ARGS_destroy = "'-auto-approve -refresh=false'"
      ENVIRONMENT         = "demo"
      LANDINGZONE_BRANCH  = "master"
      ROVER_RUNNER        = "true"
      ARM_USE_AZUREAD     = "true"
    }
  }

  level0 = {
    project_key  = "contoso_demo"
    name         = "release-level0"
    allow_access = true
    variables = {
      PIPELINE_LEVEL = "level0"
      ARM_USE_MSI    = "true"
      AGENT_POOL     = "gitops-level0"
    }
  }

  level1 = {
    project_key  = "contoso_demo"
    name         = "release-level1"
    allow_access = true
    variables = {
      PIPELINE_LEVEL = "level1"
      ARM_USE_MSI    = "true"
      AGENT_POOL     = "gitops-level1"
    }
  }

  level2 = {
    project_key  = "contoso_demo"
    name         = "release-level2"
    allow_access = true
    variables = {
      PIPELINE_LEVEL = "level2"
      ARM_USE_MSI    = "true"
      AGENT_POOL     = "gitops-level2"
    }
  }

  level3 = {
    project_key  = "contoso_demo"
    name         = "release-level3"
    allow_access = true
    variables = {
      PIPELINE_LEVEL = "level3"
      ARM_USE_MSI    = "true"
      AGENT_POOL     = "gitops-level3"
    }
  }

  level4 = {
    project_key  = "contoso_demo"
    name         = "release-level4"
    allow_access = true
    variables = {
      PIPELINE_LEVEL = "level4"
      ARM_USE_MSI    = "true"
      AGENT_POOL     = "gitops-level4"
    }
  }

  # level0 Service Principals secrets
  # level0_client_id = {
  #   project_key  = "contoso_demo"
  #   name         = "level0-sp-client-id"
  #   allow_access = true
  #   keyvault = {
  #     lz_key              = "launchpad"
  #     keyvault_key        = "level0"
  #     serviceendpoint_key = "contoso_demo"
  #   }
  #   variables = {
  #     name = "sp-client-id"
  #   }
  # }

  # level0_client_secret = {
  #   project_key  = "contoso_demo"
  #   name         = "level0-sp-client-secret"
  #   allow_access = true
  #   keyvault = {
  #     lz_key              = "launchpad"
  #     keyvault_key        = "level0"
  #     serviceendpoint_key = "contoso_demo"
  #   }
  #   variables = {
  #     name = "sp-client-secret"
  #   }
  # }
}

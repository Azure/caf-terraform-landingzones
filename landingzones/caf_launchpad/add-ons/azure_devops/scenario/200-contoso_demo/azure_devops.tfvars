

azure_devops = {

  url     = "https://dev.azure.com/azure-terraform/"
  project = "contoso_demo"

  # PAT Token should be updated manually to the keyvault after running launchpad
  pats = {
    admin = {
      secret_name  = "azdo-pat-admin"
      lz_key       = "launchpad"
      keyvault_key = "secrets"
    }
  }

  organization_agent_pools = {
    level0 = {
      name           = "caf-sandpit-level0"
      auto_provision = false # When set to false the agent pool is not populated automatically into the devops projects (recommended)
    }
    level1 = {
      name           = "caf-sandpit-level1"
      auto_provision = false
    }
    level2 = {
      name           = "caf-sandpit-level2"
      auto_provision = false
    }
    level3 = {
      name           = "caf-sandpit-level3"
      auto_provision = false
    }
    level4 = {
      name           = "caf-sandpit-level4"
      auto_provision = false
    }
  }

  project_agent_pools = {
    level0 = {
      name = "caf-sandpit-level0"
    }
    level1 = {
      name = "caf-sandpit-level1"
    }
    level2 = {
      name = "caf-sandpit-level2"
    }
    level3 = {
      name = "caf-sandpit-level3"
    }
    level4 = {
      name = "caf-sandpit-level4"
    }
  }

  service_endpoints = {
    contoso_demo = {
      endpoint_name       = "terraformdev (terraformdev.onmicrosoft.com) - contoso_demo"
      subscription_name   = "ase-landingzone"
      subscription_id     = "1d53e782-9f46-4720-b6b3-cff29106e9f6"
      aad_app_key         = "contoso_demo"
      secret_keyvault_key = "devops"
    }
  }

  variable_groups = {
    global = {
      name         = "release-global" # changing that name requires to change it in the devops agents yaml variables group
      allow_access = true
      variables = {
        HOME_FOLDER_USER    = "vsts_azpcontainer"
        ROVER_IMAGE         = "aztfmod/rover:2010.2808"
        TF_CLI_ARGS         = "'-no-color'"
        TF_CLI_ARGS_init    = ""
        TF_CLI_ARGS_plan    = "'-input=false'"
        TF_VAR_ARGS_destroy = "'-auto-approve -refresh=false'"
        ENVIRONMENT         = "sandpit"
        LANDINGZONE_BRANCH  = "2010.0.0"
      }
    }

    level0 = {
      name         = "release-level0"
      allow_access = true
      variables = {
        TF_VAR_pipeline_level = "level0"
        ARM_USE_MSI           = "true"
        AGENT_POOL            = "caf-sandpit-level0"
      }
    }

    level0_kv = {
      name         = "release-level0-msi"
      allow_access = true
      keyvault = {
        lz_key              = "launchpad"
        keyvault_key        = "level0"
        serviceendpoint_key = "contoso_demo"
      }
      variables = {
        name = "msi-resource-id"
      }
    }

    level1 = {
      name         = "release-level1"
      allow_access = true
      variables = {
        TF_VAR_pipeline_level = "level1"
        ARM_USE_MSI           = "true"
        AGENT_POOL            = "caf-sandpit-level1"
      }
    }

    level1_kv = {
      name         = "release-level1-msi"
      allow_access = true
      keyvault = {
        lz_key              = "launchpad"
        keyvault_key        = "level1"
        serviceendpoint_key = "contoso_demo"
      }
      variables = {
        name = "msi-resource-id"
      }
    }

    level2 = {
      name         = "release-level2"
      allow_access = true
      variables = {
        TF_VAR_pipeline_level = "level2"
        ARM_USE_MSI           = "true"
        AGENT_POOL            = "caf-sandpit-level2"
      }
    }

    level2_kv = {
      name         = "release-level2-msi"
      allow_access = true
      keyvault = {
        lz_key              = "launchpad"
        keyvault_key        = "level2"
        serviceendpoint_key = "contoso_demo"
      }
      variables = {
        name = "msi-resource-id"
      }
    }

    level3 = {
      name         = "release-level3"
      allow_access = true
      variables = {
        TF_VAR_pipeline_level = "level3"
        ARM_USE_MSI           = "true"
        AGENT_POOL            = "caf-sandpit-level3"
      }
    }

    level3_kv = {
      name         = "release-level3-msi"
      allow_access = true
      keyvault = {
        lz_key              = "launchpad"
        keyvault_key        = "level3"
        serviceendpoint_key = "contoso_demo"
      }
      variables = {
        name = "msi-resource-id"
      }
    }
  }

  pipelines = {

    #
    # Agent pools
    #

    devops_agent_level1_plan = {
      name          = "devops_agent_level1_plan"
      folder        = "\\configuration\\level1"
      yaml          = "configuration/pipeline/rover.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "caf-configuration"
      variables = {
        landingZoneName = "azdo-agent-level1",
        terraformAction = "plan",
        tfstateName     = "azdo-agent-level1.tfstate"
        configPath      = "/configuration/level1/azuredevops/agent"
        landingZonePath = "/public/landingzones/caf_launchpad/add-ons/azure_devops_agent"
        level           = "level1"
      }
      variable_group_keys = ["global", "level0", "level0_kv"]
    }
    devops_agent_level1_apply = {
      name          = "devops_agent_level1_apply"
      folder        = "\\configuration\\level1"
      yaml          = "configuration/pipeline/rover.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "caf-configuration"
      variables = {
        landingZoneName = "azdo-agent-level1",
        terraformAction = "apply",
        tfstateName     = "azdo-agent-level1.tfstate"
        configPath      = "/configuration/level1/azuredevops/agent"
        landingZonePath = "/public/landingzones/caf_launchpad/add-ons/azure_devops_agent"
        level           = "level1"
      }
      variable_group_keys = ["global", "level0", "level0_kv"]
    }
    devops_agent_level1_destroy = {
      name          = "devops_agent_level1_destroy"
      folder        = "\\configuration\\level1"
      yaml          = "configuration/pipeline/rover.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "caf-configuration"
      variables = {
        landingZoneName = "azdo-agent-level1",
        terraformAction = "destroy",
        tfstateName     = "azdo-agent-level1.tfstate"
        configPath      = "/configuration/level1/azuredevops/agent"
        landingZonePath = "/public/landingzones/caf_launchpad/add-ons/azure_devops_agent"
        level           = "level1"
      }
      variable_group_keys = ["global", "level0", "level0_kv"]
    }
  }
}

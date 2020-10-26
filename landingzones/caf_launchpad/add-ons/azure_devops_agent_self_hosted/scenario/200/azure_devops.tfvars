
azure_devops = {

  # Rover version to apply to the devops self-hosted agents during the setup.
  rover_version = "aztfmod/roverdev:2010.141511"

  url           = "https://dev.azure.com/azure-terraform/"
  project       = "contoso_demo"

  pipeline_level = "level0"

  pats = {
    admin = {
      secret_name  = "azdo-pat-admin"
      lz_key       = "launchpad"
      keyvault_key = "secrets"
    }
    agent = {
      secret_name  = "azdo-pat-agent"
      lz_key       = "launchpad"
      keyvault_key = "secrets"
    }
  }

  organization_agent_pools = {
    level0 = {
      name              = "caf-nonprod-level0"
      auto_provision    = true
      num_agents        = 4
      agent_name_prefix = "agent"
    }
    level1 = {
      name              = "caf-nonprod-level1"
      auto_provision    = true
      num_agents        = 2
      agent_name_prefix = "agent"
    }
    level2 = {
      name              = "caf-nonprod-level2"
      auto_provision    = true
      num_agents        = 2
      agent_name_prefix = "agent"
    }
    level3 = {
      name              = "caf-nonprod-level3"
      auto_provision    = true
      num_agents        = 4
      agent_name_prefix = "agent"
    }
    level4 = {
      name              = "caf-nonprod-level4"
      auto_provision    = true
      num_agents        = 5
      agent_name_prefix = "agent"
    }
  }

  project_agent_pools = {
    level0 = {
      name = "caf-nonprod-level0"
    }
    level1 = {
      name = "caf-nonprod-level1"
    }
    level2 = {
      name = "caf-nonprod-level2"
    }
    level3 = {
      name = "caf-nonprod-level3"
    }
    level4 = {
      name = "caf-nonprod-level4"
    }
  }

  variable_groups = {
    global = {
      name = "release-global" # changing that name requires to change it in the devops agents yaml variables group
      allow_access = true
      variables = {
        HOME_FOLDER_USER    = "vsts_azpcontainer"
        ROVER_IMAGE         = "aztfmod/roverdev:2010.141511"
        TF_CLI_ARGS         = "'-no-color'"
        TF_CLI_ARGS_init    = ""
        TF_CLI_ARGS_plan    = "'-input=false'"
        TF_VAR_ARGS_destroy = "'-auto-approve -refresh=false'"
        ENVIRONMENT         = "nonprod"
        LANDINGZONE_BRANCH  = "0.4"
      }
    }

    level0 = {
      name = "release-level0"
      variables = {
        TF_VAR_pipeline_level = "level0"
        TF_VAR_USE_MSI        = "true"
        ARM_USE_MSI           = "true"
        AGENT_POOL_LEVEL0     = "caf-nonprod-level0"
      }
    }

    level0_kv = {
      name = "release-level0-msi"
      keyvault = {
        lz_key              = "launchpad"
        keyvault_key        = "level0"
        serviceendpoint_key = "app-service-improvement-program_to-nonprod"
      }
      variables = {
        name = "msi-resource-id"
      }
    }

    level1 = {
      name = "release-level1"
      variables = {
        TF_VAR_pipeline_level = "level1"
        TF_VAR_USE_MSI        = "true"
        ARM_USE_MSI           = "true"
        AGENT_POOL_LEVEL1     = "caf-nonprod-level1"
      }
    }

    level1_kv = {
      name = "release-level1-msi"
      keyvault = {
        lz_key              = "launchpad"
        keyvault_key        = "level1"
        serviceendpoint_key = "app-service-improvement-program_to-nonprod"
      }
      variables = {
        name = "msi-resource-id"
      }
    }

    level2 = {
      name = "release-level2"
      variables = {
        TF_VAR_pipeline_level = "level2"
        TF_VAR_USE_MSI        = "true"
        ARM_USE_MSI           = "true"
        AGENT_POOL_LEVEL2     = "caf-nonprod-level2"
      }
    }

    level2_kv = {
      name = "release-level2-msi"
      keyvault = {
        lz_key              = "launchpad"
        keyvault_key        = "level2"
        serviceendpoint_key = "app-service-improvement-program_to-nonprod"
      }
      variables = {
        name = "msi-resource-id"
      }
    }

    level3 = {
      name = "release-level3"
      variables = {
        TF_VAR_pipeline_level = "level3"
        TF_VAR_USE_MSI        = "true"
        ARM_USE_MSI           = "true"
        AGENT_POOL_LEVEL3     = "caf-nonprod-level3"
      }
    }

    level3_kv = {
      name = "release-level3-msi"
      keyvault = {
        lz_key              = "launchpad"
        keyvault_key        = "level3"
        serviceendpoint_key = "app-service-improvement-program_to-nonprod"
      }
      variables = {
        name = "msi-resource-id"
      }
    }

    level4 = {
      name = "release-level4"
      variables = {
        TF_VAR_pipeline_level = "level4"
        TF_VAR_USE_MSI        = "true"
        ARM_USE_MSI           = "true"
        AGENT_POOL_LEVEL4     = "caf-nonprod-level4"
      }
    }

    level4_kv = {
      name = "release-level4-msi"
      keyvault = {
        lz_key              = "launchpad"
        keyvault_key        = "level4"
        serviceendpoint_key = "app-service-improvement-program_to-nonprod"
      }
      variables = {
        name = "msi-resource-id"
      }
    }
  }

  pipelines = {

    #
    # Level 1 - CAF Foundations
    #

    caf_foundations_plan = {
      name          = "caf_foundations_plan"
      folder        = "\\configuration\\nonprod\\level1"
      yaml          = "configuration/nonprod/level1/caf_foundations_plan.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "azure-terraform-nonprod-caf-configuration"
    }
    caf_foundations_apply = {
      name          = "caf_foundations_apply"
      folder        = "\\configuration\\nonprod\\level1"
      yaml          = "configuration/nonprod/level1/caf_foundations_apply.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "azure-terraform-nonprod-caf-configuration"
    }

    #
    # Level 2 - Shared Services and Networking Hub
    #

    caf_networking_hub_plan = {
      name          = "caf_networking_hub_plan"
      folder        = "\\configuration\\nonprod\\level2"
      yaml          = "configuration/nonprod/level2/networking/hub/pipeline_plan.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "azure-terraform-nonprod-caf-configuration"
    }
    caf_networking_hub_apply = {
      name          = "caf_networking_hub_apply"
      folder        = "\\configuration\\nonprod\\level2"
      yaml          = "configuration/nonprod/level2/networking/hub/pipeline_apply.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "azure-terraform-nonprod-caf-configuration"
    }
    caf_shared_services_plan = {
      name          = "caf_shared_services_plan"
      folder        = "\\configuration\\nonprod\\level2"
      yaml          = "configuration/nonprod/level2/shared_services/pipeline_plan.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "azure-terraform-nonprod-caf-configuration"
    }
    caf_shared_services_apply = {
      name          = "caf_shared_services_apply"
      folder        = "\\configuration\\nonprod\\level2"
      yaml          = "configuration/nonprod/level2/shared_services/pipeline_apply.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "azure-terraform-nonprod-caf-configuration"
    }
    caf_networking_spoke_ase_plan = {
      name          = "caf_networking_spoke_ase_plan"
      folder        = "\\configuration\\nonprod\\level2"
      yaml          = "configuration/nonprod/level2/networking/spoke_ase/networking_spoke_ase_plan.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "azure-terraform-nonprod-caf-configuration"
    }
    caf_networking_spoke_ase_apply = {
      name          = "caf_networking_spoke_ase_apply"
      folder        = "\\configuration\\nonprod\\level2"
      yaml          = "configuration/nonprod/level2/networking/spoke_ase/networking_spoke_ase_apply.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "azure-terraform-nonprod-caf-configuration"
    }
    

    #
    # Level 3 App Service Environments and App Service Plans
    #


    caf_ase1_asp_plan = {
      name          = "caf_ase1_asp_plan"
      folder        = "\\configuration\\nonprod\\level3\\shared\\app_services\\ase1"
      yaml          = "configuration/nonprod/level3/shared/app_services/pipeline.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "azure-terraform-nonprod-caf-configuration"
      variables     = {
        ase               = "ase1",
        terraformAction   = "plan",
        tfstateName       = "ase1.tfstate"
      }
    }
    caf_ase1_asp_apply = {
      name          = "caf_ase1_asp_apply"
      folder        = "\\configuration\\nonprod\\level3\\shared\\app_services\\ase1"
      yaml          = "configuration/nonprod/level3/shared/app_services/pipeline.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "azure-terraform-nonprod-caf-configuration"
      variables     = {
        ase               = "ase1",
        terraformAction   = "apply",
        tfstateName       = "ase1.tfstate"
      }
    }
    caf_application_gateway_plan = {
      name          = "caf_application_gateway_plan"
      folder        = "\\configuration\\nonprod\\level3\\shared\\application_gateway"
      yaml          = "configuration/nonprod/level3/shared/application_gateway/pipeline_plan.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "azure-terraform-nonprod-caf-configuration"
    }
    caf_application_gateway_apply = {
      name          = "caf_application_gateway_apply"
      folder        = "\\configuration\\nonprod\\level3\\shared\\application_gateway"
      yaml          = "configuration/nonprod/level3/shared/application_gateway/pipeline_apply.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "azure-terraform-nonprod-caf-configuration"
    }

    demo_app1 = {
      name          = "demo_app1_infrastructure"
      folder        = "\\configuration\\nonprod\\level3\\applications"
      yaml          = "configuration/nonprod/level3/applications/demo_app1/pipeline_apply.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "azure-terraform-nonprod-caf-configuration"
    }
    demo_app2 = {
      name          = "demo_app2_infrastructure"
      folder        = "\\configuration\\nonprod\\level3\\applications"
      yaml          = "configuration/nonprod/level3/applications/demo_app2/pipeline_apply.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "azure-terraform-nonprod-caf-configuration"
    }

    #
    # Level4
    #

  }

  service_endpoints = {

    app-service-improvement-program_to-nonprod = {
      endpoint_name       = "PETRONAS (PETRONAS.onmicrosoft.com) - PTAZSG-DEV ENVIRONMENT"
      subscription_name   = "PTAZSG-DEV ENVIRONMENT"
      subscription_id     = "b5a67ad5-d38a-4258-aa5e-31e39d3b709f"
      aad_app_key         = "app-service-improvement-program_to-nonprod"
      secret_keyvault_key = "devops_vm_rg1"
    }
  }

}
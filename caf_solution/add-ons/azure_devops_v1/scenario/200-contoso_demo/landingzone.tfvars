landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "launchpad"
  level               = "level1"
  key                 = "contoso_demo_azure_devops_projects"
  tfstates = {
    launchpad = {
      level   = "lower"
      tfstate = "tf-prod-gitops-caf-level0_launchpad.tfstate"
    }
  }
}
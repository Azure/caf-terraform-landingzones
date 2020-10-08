locals {
  es_custom_management_groups = {
    caf-launchpad = {
      display_name               = "Cloud Adoption Framework - DevOps launchpad"
      parent_management_group_id = "caf-launchpad"
      subscription_ids           = []
      archetype_config = {
        archetype_id = "es_management"
        parameters   = {
          ES-Deploy-ForwardDiagLog = {
            logAnalytics = local.diagnostics.log_analytics["central_logs_region1"].id
          }
          # ES-Allowed-Locations = {
          #   listOfAllowedLocations = [
          #     "eastus"
          #   ]
          # }
        }
      }
    }
  }
}
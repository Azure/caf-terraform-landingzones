locals {
  es_custom_management_groups = var.enterprise_scale == {} ? {} : {
    caf-launchpad = {
      display_name               = "Cloud Adoption Framework - DevOps launchpad"
      parent_management_group_id = ""
      subscription_ids           = []
      archetype_config = {
        archetype_id = "es_management"
        parameters = {
          ES-Deploy-ForwardDiagLog = {
            logAnalytics = try(local.diagnostics.log_analytics[var.enterprise_scale.log_analytics_key].id, null)
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
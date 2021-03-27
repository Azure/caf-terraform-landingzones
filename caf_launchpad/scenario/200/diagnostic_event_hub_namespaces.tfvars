
# Event hub diagnostics
diagnostic_event_hub_namespaces = {
  central_logs_region1 = {
    name               = "logs"
    resource_group_key = "ops"
    sku                = "Standard"
    region             = "region1"

    diagnostic_profiles = {
      central_logs_region1 = {
        definition_key   = "event_hub_namespace"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
    }
  }
}



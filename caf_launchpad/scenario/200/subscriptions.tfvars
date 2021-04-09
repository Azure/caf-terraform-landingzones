
subscriptions = {
  logged_in_subscription = {

    # you can setup up to 5 profiles
    diagnostic_profiles = {
      operations = {
        definition_key   = "subscription_operations"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
      siem = {
        definition_key   = "subscription_siem"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
    }

  }
}
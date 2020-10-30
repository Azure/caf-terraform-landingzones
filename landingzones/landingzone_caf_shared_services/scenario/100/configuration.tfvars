level = "level2"

landingzone_name = "shared_services"

resource_groups = {
  alerts = {
    name = "alerts"
  }
}

#refer README
monitoring = {
  service_health_alerts = {
    enable_service_health_alerts = true
    name                         = "service-health-alert"
    action_group_name            = "ag_servicehealth"
    shortname                    = "HealthAlerts"
    resource_group_key           = "alerts"

    email_alert_settings = [
      {
        name                    = "email_alert_servicehealth_me"
        email_address           = "email1@domain"
        use_common_alert_schema = false
      }, #remove the following block if additional email alerts aren't needed. 
      {
        name                    = "email_alert_servicehealth_somoneelse"
        email_address           = "email2@domain"
        use_common_alert_schema = false
      }
    ] #add more email alerts by repeating the block.

    #more alert settings can be dynamically added/removed by commenting in/out the following blocks
    #sms_alert_settings = [
    # {
    #   name = "sms_alert_servicehealth"          
    #   country_code = "65"
    #   phone_number = "0000000"
    # }
    #]

    #webhook = [
    # {
    #   name = "webhook_trigger_servicehealth"          
    #   service_uri = "https://uri"
    # }
    #]

    arm_role_alert = [
      {
        name = "arm_role_alert_servicehealth"
        # refer https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles
        role_id                 = "b24988ac-6180-42a0-ab88-20f7382dd24c" #UUID for Contributor Role
        use_common_alert_schema = false
      }
    ]


  }

}

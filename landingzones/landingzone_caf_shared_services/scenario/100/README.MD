[![Gitter](https://badges.gitter.im/aztfmod/community.svg)](https://gitter.im/aztfmod/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

# Shared Services -  Service Health Alerts
This configuration tracks the following types of health events (subscription wide) and send alerts:

1. Service issues - Problems in the Azure services that affect you right now.

2. Planned maintenance - Upcoming maintenance that can affect the availability of your services in the future.

3. Health advisories - Changes in Azure services that require your attention. 

4. Security advisories - Security related notifications or violations that may affect the availability of your Azure services.

Ref : https://docs.microsoft.com/en-us/azure/service-health/service-health-overview

An Action Group will be created and your choice of Notifications type can be chosen dynamically (refer input syntax). 
Due to the some limitations, Service Health Alerts are being created using an ARM Template and is embedded within the Terraform script.


## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurecaf | n/a |
| azurerm | n/a |

##  Input Syntax
```hcl
  # refer example configuration file
   monitoring = {
    service_health_alerts = {
        enable_service_health_alerts = true/false
        name = "<string>"
        location = ["region1", "region2"] 
        #add/modify more regions if needed; must be supplied in a List.
        action_group_name = "<string>"
        shortname = "<string>"
        resource_group_key = "<string>"
        
        email_alert_settings = [
          {
            name = "<string>"        
            email_address = "<emailAddress>"
            use_common_alert_schema = true/false
          },
          #remove the following block if additional email alerts aren't needed.
          {
            name = "<string>"          
            email_address = "<emailAddress>"
            use_common_alert_schema = true/false
          }
          ##add more email alerts by repeating the block.
        ]
            
        #comment out this block exclude this configuration completely
        sms_alert_settings = [
           { 
             name = "<string>"       
             country_code ="<countryCode>"
             phone_number = "<phoneNumber>"
           } #follow the syntax of email alert settings to have one or more alerts
        ]

        #comment out this block exclude this configuration completely
        #webhook = [
          # { 
          #   name = "<string>"         
          #   service_uri = "<URI>"
          # } #follow the syntax of email alert settings to have one or more alerts
        #]

        #comment out this block exclude this configuration completely
        arm_role_alert = [
          {
            name = "<string>"          
            # refer https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles
            role_id = "b24988ac-6180-42a0-ab88-20f7382dd24c"  #UUID for Contributor Role
            use_common_alert_schema = true/false
          } #follow the syntax of email alert settings to have one or more alerts
        ]

    
    }
    
}
    
}
```

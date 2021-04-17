custom_landing_zones = {

  contoso-devops = {
    display_name               = "Devops"
    parent_management_group_id = "contoso-platform"
    subscription_ids           = []
    archetype_config = {
      archetype_id   = "default_empty"
      parameters     = {}
      access_control = {}
    }
  }

  contoso-staging = {
    display_name               = "Staging"
    parent_management_group_id = "contoso-landing-zones"
    subscription_ids           = []
    archetype_config = {
      archetype_id   = "default_empty"
      parameters     = {}
      access_control = {}
    }
  }

  contoso-dev = {
    display_name               = "Dev"
    parent_management_group_id = "contoso-landing-zones"
    subscription_ids           = []
    archetype_config = {
      archetype_id   = "default_empty"
      parameters     = {}
      access_control = {}
    }
  }

  contoso-production = {
    display_name               = "Production"
    parent_management_group_id = "contoso-landing-zones"
    subscription_ids           = []
    archetype_config = {
      archetype_id   = "default_empty"
      parameters     = {}
      access_control = {}
    }
  }

}
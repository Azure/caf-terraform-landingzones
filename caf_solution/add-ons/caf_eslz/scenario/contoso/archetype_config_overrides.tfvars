archetype_config_overrides = {

  root = {
    archetype_id = "es_root"
    parameters = {
      "Deploy-Resource-Diag" = {
        "logAnalytics" = {
          # value = "resource_id"
          lz_key        = "caf_foundations_sharedservices"
          output_key    = "diagnostics"
          resource_type = "log_analytics"
          resource_key  = "central_logs_region1"
          attribute_key = "id"
        }
      }
    }
    access_control = {
      "Contributor" = {
        "managed_identities" = {
          # principal_ids = ["principal_id1", "principal_id2"]
          lz_key        = "launchpad"
          attribute_key = "principal_id"
          resource_keys = [
            "level1"
          ]
        }
      }
    }
  }

  # decommissioned = {
  #   archetype_id   = "es_decommissioned"
  #   parameters     = {}
  #   access_control = {}
  # }

  # sandboxes = {
  #   archetype_id   = "es_sandboxes"
  #   parameters     = {}
  #   access_control = {}
  # }

  landing-zones = {
    archetype_id = "es_landing_zones"
    parameters   = {}
    access_control = {
      "Contributor" = {
        "managed_identities" = {
          # principal_ids = ["principal_id1", "principal_id2"]
          lz_key        = "launchpad"
          attribute_key = "principal_id"
          resource_keys = [
            "level3", "subscription_creation_landingzones"
          ]
        }
      }
    }
  }

  # platform = {
  #   archetype_id   = "es_platform"
  #   parameters     = {}
  #   access_control = {}
  # }

  # connectivity = {
  #   archetype_id   = "es_connectivity_foundation"
  #   parameters     = {}
  #   access_control = {}
  # }

  # management = {
  #   archetype_id   = "es_management"
  #   parameters     = {}
  #   access_control = {}
  # }
}
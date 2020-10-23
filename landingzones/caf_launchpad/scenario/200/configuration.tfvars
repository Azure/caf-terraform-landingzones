landingzone = {
  backend_type = "azurerm"
  level        = "level0"
  key          = "launchpad"
}

enable = {
  bastion_hosts    = false
  virtual_machines = false
}


# Default region. When not set to a resource it will use that value
default_region = "region1"

inherit_tags = true

regions = {
  region1 = "southeastasia"
  region2 = "eastasia"
}

launchpad_key_names = {
  azuread_app            = "caf_launchpad_level0"
  keyvault_client_secret = "aadapp-caf-launchpad-level0"
  tfstates = [
    "level0",
    "level1",
    "level2",
    "level3",
    "level4"
  ]
}

resource_groups = {
  level0 = {
    name = "launchpad-level0"
    tags = {
      level = "level0"
    }
  }
  level1 = {
    name = "launchpad-level1"
    tags = {
      level = "level1"
    }
  }
  level2 = {
    name = "launchpad-level2"
    tags = {
      level = "level2"
    }
  }
  level3 = {
    name = "launchpad-level3"
    tags = {
      level = "level3"
    }
  }
  level4 = {
    name = "launchpad-level4"
    tags = {
      level = "level4"
    }
  }
  security = {
    name = "launchpad-security"
  }
  networking = {
    name = "launchpad-networking"
  }
  ops = {
    name = "operations"
  }
  siem = {
    name = "siem-logs"
  }
  bastion_launchpad = {
    name = "launchpad-bastion"
  }
}


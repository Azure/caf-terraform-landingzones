
storage_accounts = {
  level0 = {
    name                     = "level0"
    resource_group_key       = "level0"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "RAGRS"
    tags = {
      ## Those tags must never be changed after being set as they are used by the rover to locate the launchpad and the tfstates.
      # Only adjust the environment value at creation time
      tfstate     = "level0"
      environment = "sandpit"
      launchpad   = "launchpad"
      ##
    }
    containers = {
      tfstate = {
        name = "tfstate"
      }
    }
  }


  level1 = {
    name                     = "level1"
    resource_group_key       = "level1"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "RAGRS"
    tags = {
      # Those tags must never be changed while set as they are used by the rover to locate the launchpad and the tfstates.
      tfstate     = "level1"
      environment = "sandpit"
      launchpad   = "launchpad"
    }
    containers = {
      tfstate = {
        name = "tfstate"
      }
    }
  }

  level2 = {
    name                     = "level2"
    resource_group_key       = "level2"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "RAGRS"
    tags = {
      # Those tags must never be changed while set as they are used by the rover to locate the launchpad and the tfstates.
      tfstate     = "level2"
      environment = "sandpit"
      launchpad   = "launchpad"
    }
    containers = {
      tfstate = {
        name = "tfstate"
      }
    }
  }

  level3 = {
    name                     = "level3"
    resource_group_key       = "level3"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "RAGRS"
    tags = {
      # Those tags must never be changed while set as they are used by the rover to locate the launchpad and the tfstates.
      tfstate     = "level3"
      environment = "sandpit"
      launchpad   = "launchpad"
    }
    containers = {
      tfstate = {
        name = "tfstate"
      }
    }
  }

  level4 = {
    name                     = "level4"
    resource_group_key       = "level4"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "RAGRS"
    tags = {
      # Those tags must never be changed while set as they are used by the rover to locate the launchpad and the tfstates.
      tfstate     = "level4"
      environment = "sandpit"
      launchpad   = "launchpad"
    }
    containers = {
      tfstate = {
        name = "tfstate"
      }
    }

  }

}

managed_identities = {
  level0 = {
    # Used by the release agent to access the level0 keyvault and storage account with the tfstates in read / write
    name               = "landingzone-level0-msi"
    resource_group_key = "security"
  }
  level1 = {
    # Used by the release agent to access the level1 keyvault and storage account with the tfstates in read / write
    # Has read access to level0
    name               = "landingzone-level1-msi"
    resource_group_key = "security"
  }
  level2 = {
    # Used by the release agent to access the level2 keyvault and storage account with the tfstates in read / write
    # Has read access to level1
    name               = "landingzone-level2-msi"
    resource_group_key = "security"
  }
  level3 = {
    # Used by the release agent to access the level3 keyvault and storage account with the tfstates in read / write
    # Has read access to level2
    name               = "landingzone-level3-msi"
    resource_group_key = "security"
  }
  level4 = {
    # Used by the release agent to access the level4 keyvault and storage account with the tfstates in read / write
    # Has read access to level3
    name               = "landingzone-level4-msi"
    resource_group_key = "security"
  }
}

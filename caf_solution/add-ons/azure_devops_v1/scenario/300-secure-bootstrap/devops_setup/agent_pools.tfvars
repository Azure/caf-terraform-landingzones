organization_agent_pools = {
  level0 = {
    name           = "contoso-level0"
    auto_provision = false # When set to false the agent pool is not populated automatically into the devops projects (recommended)
  }
  level1 = {
    name           = "contoso-level1"
    auto_provision = false
  }
  level2 = {
    name           = "contoso-level2"
    auto_provision = false
  }
}

project_agent_pools = {
  contoso = {
    level0 = {
      key          = "level0"
      grant_access = true
    }
    level1 = {
      key          = "level1"
      grant_access = true
    }
    level2 = {
      key          = "level2"
      grant_access = true
    }
  }
}
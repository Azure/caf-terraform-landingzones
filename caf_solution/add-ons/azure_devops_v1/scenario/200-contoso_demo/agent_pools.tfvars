organization_agent_pools = {
  level0 = {
    name           = "gitops-level0"
    auto_provision = false # When set to false the agent pool is not populated automatically into the devops projects (recommended)
  }
  level1 = {
    name           = "gitops-level1"
    auto_provision = false
  }
  level2 = {
    name           = "gitops-level2"
    auto_provision = false
  }
  level3 = {
    name           = "gitops-level3"
    auto_provision = false
  }
}

project_agent_pools = {
  contoso_demo = {
    level0 = {
      key = "level0"

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
    level3 = {
      key          = "level3"
      grant_access = true
    }
  }
}
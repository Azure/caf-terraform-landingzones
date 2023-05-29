projects = {
  contoso = {
    create      = false
    name        = "backend-tfe-migration"
    description = "Project to hold the LZ setup"
    features = {
      "artifacts"    = "enabled"
      "boards"       = "enabled"
      "pipelines"    = "enabled"
      "repositories" = "enabled"
      "testplans"    = "enabled"
    }
  }
}
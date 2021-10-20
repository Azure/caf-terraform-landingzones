projects = {
  contoso_demo = {
    create      = true
    name        = "contoso_demo"
    description = "Contoso - Demo"
    features = {
      "artifacts"    = "disabled"
      "boards"       = "disabled"
      "pipelines"    = "enabled"
      "repositories" = "enabled"
      "testplans"    = "disabled"
    }
  }
}

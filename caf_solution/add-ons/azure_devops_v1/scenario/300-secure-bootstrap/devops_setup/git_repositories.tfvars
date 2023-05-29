git_repositories = {
  landingzone = {
    name = "aztfmod_landingzone"
    project = {
      key = "contoso"
    }
    default_branch = "refs/heads/main"
    initialization = {
      init_type   = "Import"
      source_type = "Git"
      source_url  = "https://github.com/Azure/caf-terraform-landingzones.git"
    }
  }
}
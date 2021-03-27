landingzone = {
  backend_type = "remote"
  level        = "level0"
  key          = "launchpad"
}

# Create the TFC organization
tfe_organizations = {
  caf_lz = {
    name  = "caf-landingzones-test3"
    email = "admin@your-company.com"

  }
}

# Create the required TFE workspaces
tfe_workspaces = {
  caf_launchpad = {
    # specifies the object key for the organization where to create the workspace
    organization_key = "caf_lz"
    name             = "caf_launchpad"
    # path to place the backend file for the corresponding landing zone
    backend_file = "/backend.hcl"
  }
}
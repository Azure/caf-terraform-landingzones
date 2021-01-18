locals {
  azure_workspace_resource_id = local.caf.databricks_workspaces[var.databricks.workspace_key].id
}

provider "databricks" {
  azure_workspace_resource_id = local.azure_workspace_resource_id
  # azure_client_id             = var.client_id
  # azure_client_secret         = var.client_secret
  # azure_tenant_id             = var.tenant_id
}

module databricks {
  source = "../../modules/databricks"

  settings = var.databricks
}

output databricks {
  value     = module.databricks
  sensitive = false
}

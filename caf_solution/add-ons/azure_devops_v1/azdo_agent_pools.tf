
locals {
  organization_agent_pools = try(var.organization_agent_pools, {})
  project_agent_pools      = try(var.project_agent_pools, {})
}



## Agent pools
## Those pools are created in the organization, not the project
resource "azuredevops_agent_pool" "pool" {
  for_each = var.organization_agent_pools

  name           = each.value.name
  auto_provision = try(each.value.auto_provision, false)
  pool_type      = try(each.value.pool_type, null)
}

output "agent_pools" {
  value = azuredevops_agent_pool.pool
}


#
# add the agent pools into the project
#


module "project_agent_pools" {
  source   = "./agent_pools"
  for_each = var.project_agent_pools

  azuredevops_agent_pools = azuredevops_agent_pool.pool
  project_id              = data.azuredevops_project.project[each.key].id
  settings                = each.value

  depends_on = [
    azuredevops_agent_pool.pool,
    azuredevops_project.project
  ]
}




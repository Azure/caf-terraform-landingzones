
locals {
  organization_agent_pools = try(var.azure_devops.organization_agent_pools, {})
  project_agent_pools      = try(var.azure_devops.project_agent_pools, {})
}


## Agent pools
## Those pools are created in the organization, not the project
resource "azuredevops_agent_pool" "pool" {
  for_each = try(var.azure_devops.organization_agent_pools, {})

  name           = each.value.name
  auto_provision = lookup(each.value, "auto_provision", false)
}

#
# add the agent pools into the project
#

data "azuredevops_agent_pool" "pool" {
  depends_on = [azuredevops_agent_pool.pool]
  for_each   = try(var.azure_devops.project_agent_pools, {})

  name = each.value.name
}

resource "azuredevops_agent_queue" "agent_queue" {
  for_each = data.azuredevops_agent_pool.pool

  project_id    = data.azuredevops_project.project.id
  agent_pool_id = each.value.id

  lifecycle {
    ignore_changes = [
      agent_pool_id
    ]
  }
}

#
# Grant acccess to queue to all pipelines in the project
#

resource "azuredevops_resource_authorization" "queue" {
  for_each = data.azuredevops_agent_pool.pool

  project_id  = data.azuredevops_project.project.id
  resource_id = azuredevops_agent_queue.agent_queue[each.key].id
  type        = "queue"
  authorized  = true
}
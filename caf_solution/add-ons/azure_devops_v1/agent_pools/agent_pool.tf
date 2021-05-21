# Get Agent pools by name
data "azuredevops_agent_pool" "pool" {
  for_each = {
    for key, value in var.settings : key => value
    if try(value.name, null) != null
  }

  name = each.value.name
}

resource "azuredevops_agent_queue" "agent_queue" {
  for_each = var.settings

  project_id    = var.project_id
  agent_pool_id = try(data.azuredevops_agent_pool.pool[each.key].id, var.azuredevops_agent_pools[each.value.key].id)
}

#
# Grant acccess to queue to all pipelines in the project
#

resource "azuredevops_resource_authorization" "queue" {
  for_each = var.settings

  project_id  = var.project_id
  resource_id = azuredevops_agent_queue.agent_queue[each.key].id
  type        = "queue"
  authorized  = try(each.value.grant_access, false)


}


output "azuredevops_resource_authorization" {
  value = azuredevops_resource_authorization.queue
}

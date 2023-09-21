module "container_app_environments" {
  depends_on = [module.caf]
  source     = "./container_app_environment"
  for_each   = var.container_app_environments

  name                                = each.value.name
  location                            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined.resource_groups[try(each.value.resource_group.lz_key, var.landingzone.key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_id                   = can(each.value.resource_group.id) || can(each.value.resource_group_id) ? try(each.value.resource_group.id, each.value.resource_group_id) : local.combined.resource_groups[try(each.value.resource_group.lz_key, var.landingzone.key)][try(each.value.resource_group_key, each.value.resource_group.key)].id
  base_tags                           = try(local.global_settings.inherit_tags, false) ? try(local.remote.resource_groups[try(each.value.resource_group.lz_key, var.landingzone.key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  log_analytics_workspace_id          = can(each.value.log_analytics_workspace.id) ? try(local.diagnostics.log_analytics[each.value.diagnostic_log_analytics_workspace.key].id, each.value.log_analytics_workspace.id) : local.remote.diagnostics[try(each.value.log_analytics_workspace.lz_key, var.landingzone.key)].log_analytics[each.value.log_analytics_workspace.key].workspace_id
  log_analytics_primary_shared_key    = can(each.value.log_analytics_workspace.primary_shared_key) ? try(local.diagnostics.log_analytics[each.value.diagnostic_log_analytics_workspace.key].id, each.value.log_analytics_workspace.id) : local.remote.diagnostics[try(each.value.log_analytics_workspace.lz_key, var.landingzone.key)].log_analytics[each.value.log_analytics_workspace.key].primary_shared_key
  subnet_id                           = can(each.value.subnet_id) || can(each.value.subnet) == false ? try(each.value.subnet_id, null) : try(local.remote.vnets[try(each.value.subnet.lz_key, var.landingzone.key)][each.value.subnet.vnet_key].subnets[each.value.subnet.key].id)
  global_settings                     = local.global_settings
  settings                            = each.value

}

output "container_app_environments" {
  value = module.container_app_environments
}
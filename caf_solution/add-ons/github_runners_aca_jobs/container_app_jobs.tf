module "container_app_jobs" {
  depends_on = [ module.caf, module.container_app_environments]
  source     = "./container_app_job"
  for_each   = var.container_app_jobs

  name                                = each.value.name
  client_config                       = module.caf.client_config
  container_app_environment_id        = can(each.value.container_app_environment_id) ? each.value.container_app_environment_id : module.container_app_environments[try(each.value.container_app_environment.key, each.value.container_app_environment_key)].id
  location                            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined.resource_groups[try(each.value.resource_group.lz_key, var.landingzone.key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_id                   = can(each.value.resource_group.id) || can(each.value.resource_group_id) ? try(each.value.resource_group.id, each.value.resource_group_id) : local.combined.resource_groups[try(each.value.resource_group.lz_key, var.landingzone.key)][try(each.value.resource_group_key, each.value.resource_group.key)].id
  global_settings                     = local.global_settings
  settings                            = each.value

  combined_resources                  = {
    managed_identities                = try(local.combined.managed_identities, {})
    keyvaults                         = try(local.combined.keyvaults, {})
    dynamic_keyvault_secrets          = try(var.dynamic_keyvault_secrets,{})
  }
  
}

output "container_app_jobs" {
  value = module.container_app_jobs
}
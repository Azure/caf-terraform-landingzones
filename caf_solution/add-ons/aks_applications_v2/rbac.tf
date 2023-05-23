module "role" {
  source                     = "./role"
  for_each                   = var.role
  global_settings            = local.global_settings
  settings                   = each.value
  managed_identities         = local.remote.managed_identities
  azuread_groups             = local.remote.azuread_groups
  azuread_service_principals = local.remote.azuread_service_principals
}

module "role_binding" {
  source                     = "./role_binding"
  for_each                   = var.role_binding
  depends_on                 = [module.app]
  role                       = var.role
  global_settings            = local.global_settings
  settings                   = each.value
  managed_identities         = local.remote.managed_identities
  azuread_groups             = local.remote.azuread_groups
  azuread_service_principals = local.remote.azuread_service_principals
  namespaces                 = var.namespaces
}

module "cluster_role" {
  source                     = "./cluster_role"
  for_each                   = var.cluster_role
  global_settings            = local.global_settings
  settings                   = each.value
  managed_identities         = local.remote.managed_identities
  azuread_groups             = local.remote.azuread_groups
  azuread_service_principals = local.remote.azuread_service_principals
}

module "cluster_role_binding" {
  source                     = "./cluster_role_binding"
  for_each                   = var.cluster_role_binding
  cluster_role               = var.cluster_role
  global_settings            = local.global_settings
  settings                   = each.value
  managed_identities         = local.remote.managed_identities
  azuread_groups             = local.remote.azuread_groups
  azuread_service_principals = local.remote.azuread_service_principals
}
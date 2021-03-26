locals {
  landingzone = {
    current = {
      storage_account_name = var.tfstate_storage_account_name
      container_name       = var.tfstate_container_name
      resource_group_name  = var.tfstate_resource_group_name
    }
    lower = {
      storage_account_name = var.lower_storage_account_name
      container_name       = var.lower_container_name
      resource_group_name  = var.lower_resource_group_name
    }
  }
}

data "terraform_remote_state" "remote" {
  for_each = try(var.landingzone.tfstates, {})

  backend = var.landingzone.backend_type
  config = {
    storage_account_name = local.landingzone[try(each.value.level, "current")].storage_account_name
    container_name       = local.landingzone[try(each.value.level, "current")].container_name
    resource_group_name  = local.landingzone[try(each.value.level, "current")].resource_group_name
    key                  = each.value.tfstate
  }
}

locals {
  landingzone_tag = {
    "landingzone" = var.landingzone.key
  }

  tags = merge(local.global_settings.tags, local.landingzone_tag, { "level" = var.landingzone.level }, { "environment" = local.global_settings.environment }, { "rover_version" = var.rover_version }, var.tags)

  global_settings = data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.global_settings

  remote = {
    aks_clusters = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.aks_clusters[key], {}))
    }
  }

  clusters = local.remote.aks_clusters[var.landingzone.global_settings_key]
  k8sconfigs = { for key, value in values(local.clusters) : key => {
    host                   = value.enable_rbac ? value.kube_admin_config.0.host : value.kube_config.0.host
    username               = value.enable_rbac ? value.kube_admin_config.0.username : value.kube_config.0.username
    password               = value.enable_rbac ? value.kube_admin_config.0.password : value.kube_config.0.password
    client_certificate     = value.enable_rbac ? base64decode(value.kube_admin_config.0.client_certificate) : base64decode(value.kube_config.0.client_certificate)
    client_key             = value.enable_rbac ? base64decode(value.kube_admin_config.0.client_key) : base64decode(value.kube_config.0.client_key)
    cluster_ca_certificate = value.enable_rbac ? base64decode(value.kube_admin_config.0.cluster_ca_certificate) : base64decode(value.kube_config.0.cluster_ca_certificate)
    }
  }

}

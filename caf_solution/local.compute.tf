locals {
  compute = merge(
    var.compute,
    {
      aks_clusters                            = var.aks_clusters
      aro_clusters                            = var.aro_clusters
      availability_sets                       = var.availability_sets
      azure_container_registries              = var.azure_container_registries
      bastion_hosts                           = var.bastion_hosts
      batch_accounts                          = var.batch_accounts
      batch_applications                      = var.batch_applications
      batch_certificates                      = var.batch_certificates
      batch_jobs                              = var.batch_jobs
      batch_pools                             = var.batch_pools
      container_apps                          = var.container_apps
      container_app_dapr_components           = var.container_app_dapr_components
      container_app_environments              = var.container_app_environments
      container_app_environment_certificates  = var.container_app_environment_certificates
      container_app_environment_storages      = var.container_app_environment_storages
      container_groups                        = var.container_groups
      dedicated_host_groups                   = var.dedicated_host_groups
      dedicated_hosts                         = var.dedicated_hosts
      machine_learning_compute_instance       = var.machine_learning_compute_instance
      proximity_placement_groups              = var.proximity_placement_groups
      runbooks                                = var.runbooks
      virtual_machine_scale_sets              = var.virtual_machine_scale_sets
      virtual_machines                        = var.virtual_machines
      vmware_clusters                         = var.vmware_clusters
      vmware_express_route_authorizations     = var.vmware_express_route_authorizations
      vmware_private_clouds                   = var.vmware_private_clouds
      wvd_application_groups                  = var.wvd_application_groups
      wvd_applications                        = var.wvd_applications
      wvd_host_pools                          = var.wvd_host_pools
      wvd_workspaces                          = var.wvd_workspaces
    }
  )
}
locals {
  compute = merge(
    var.compute,
    {
      aks_clusters               = var.aks_clusters
      availability_sets          = var.availability_sets
      azure_container_registries = var.azure_container_registries
      bastion_hosts              = var.bastion_hosts
      container_groups           = var.container_groups
      dedicated_host_groups      = var.dedicated_host_groups
      dedicated_hosts            = var.dedicated_hosts
      proximity_placement_groups = var.proximity_placement_groups
      virtual_machines           = var.virtual_machines
      virtual_machine_scale_sets = var.virtual_machine_scale_sets
      wvd_applications           = var.wvd_applications
      wvd_application_groups     = var.wvd_application_groups
      wvd_host_pools             = var.wvd_host_pools
      wvd_workspaces             = var.wvd_workspaces
    }
  )
}
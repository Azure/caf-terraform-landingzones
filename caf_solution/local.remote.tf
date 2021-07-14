locals {
  remote = {
    azuread_apps = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].azuread_apps, {}))
    }
    azuread_applications = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].azuread_applications, {}))
    }
    azuread_groups = merge(
      tomap({ "launchpad" = try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.launchpad_identities["launchpad"].azuread_groups, {}) }),
      {
        for key, value in try(var.landingzone.tfstates, {}) : key => merge(
          try(data.terraform_remote_state.remote[key].outputs.objects[key].azuread_groups, {})
        )
      }
    )
    azuread_service_principals = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].azuread_service_principals, {}))
    }
    azuread_users = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].azuread_users, {}))
    }
    aks_clusters = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].aks_clusters, {}))
    }
    app_config = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].app_config, {}))
    }
    app_service_environments = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].app_service_environments, {}))
    }
    app_service_plans = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].app_service_plans, {}))
    }
    app_services = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].app_services, {}))
    }
    application_security_groups = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].application_security_groups, {}))
    }
    application_gateway_applications = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].application_gateway_applications, {}))
    }
    application_gateway_waf_policies = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].application_gateway_waf_policies, {}))
    }
    application_gateways = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].application_gateways, {}))
    }
    availability_sets = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].availability_sets, {}))
    }
    azuread_users = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].azuread_users, {}))
    }
    azurerm_firewall_policies = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].azurerm_firewall_policies, {}))
    }
    azurerm_firewalls = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].azurerm_firewalls, {}))
    }
    container_registry = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].container_registry, {}))
    }
    disk_encryption_sets = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].disk_encryption_sets, {}))
    }
    dedicated_hosts = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].dedicated_hosts, {}))
    }
    dedicated_host_groups = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].dedicated_host_groups, {}))
    }
    dns_zones = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].dns_zones, {}))
    }
    event_hub_namespaces = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].event_hub_namespaces, {}))
    }
    front_door_waf_policies = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].front_door_waf_policies, {}))
    }
    integration_service_environment = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].integration_service_environment, {}))
    }
    keyvault_certificate_requests = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].keyvault_certificate_requests, {}))
    }
    keyvault_keys = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].keyvault_keys, {}))
    }
    keyvaults = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].keyvaults, {}))
    }
    logic_app_integration_account = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].logic_app_integration_account, {}))
    }
    logic_app_workflow = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].logic_app_workflow, {}))
    }
    machine_learning_workspaces = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].machine_learning_workspaces, {}))
    }
    managed_identities = merge(
      tomap({ "launchpad" = try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.launchpad_identities["launchpad"].managed_identities, {}) }),
      {
        for key, value in try(var.landingzone.tfstates, {}) : key => merge(
          try(data.terraform_remote_state.remote[key].outputs.objects[key].managed_identities, {})
        )
      }
    )
    mssql_databases = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].mssql_databases, {}))
    }
    mssql_elastic_pools = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].mssql_elastic_pools, {}))
    }
    mssql_managed_databases = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].mssql_managed_databases, {}))
    }
    mssql_managed_instances = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].mssql_managed_instances, {}))
    }
    mssql_servers = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].mssql_servers, {}))
    }
    mysql_servers = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].mysql_servers, {}))
    }
    nat_gateways = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].nat_gateways, {}))
    }
    network_security_groups = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].network_security_groups, {}))
    }
    network_watchers = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].network_watchers, {}))
    }
    postgresql_servers = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].postgresql_servers, {}))
    }
    private_dns = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].private_dns, {}))
    }
    proximity_placement_groups = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].proximity_placement_groups, {}))
    }
    public_ip_addresses = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].public_ip_addresses, {}))
    }
    recovery_vaults = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].recovery_vaults, {}))
    }
    resource_groups = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].resource_groups, {}))
    }
    storage_accounts = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].storage_accounts, {}))
    }
    subscriptions = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].subscriptions, {}))
    }
    synapse_workspaces = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].synapse_workspaces, {}))
    }
    virtual_hub_connections = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].virtual_hub_connections, {}))
    }
    virtual_hub_route_tables = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].virtual_hub_route_table, {}))
    }
    virtual_hubs = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].virtual_hubs, {}))
    }
    virtual_wans = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].virtual_wans, {}))
    }
    vnets = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].vnets, {}))
    }
    vpn_sites = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].vpn_sites, {}))
    }
    vpn_gateway_connections = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].vpn_gateway_connections, {}))
    }
    wvd_host_pools = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].wvd_host_pools, {}))
    }
    wvd_application_groups = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].wvd_application_groups, {}))
    }
    wvd_workspaces = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].wvd_workspaces, {}))
    }
  }
}

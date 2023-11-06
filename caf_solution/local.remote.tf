locals {
  remote = {
    azuread_apps = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].azuread_apps, {}), try(data.terraform_remote_state.remote[key].outputs.objects[key].aad_apps, {}))
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
    app_service_environments_v3 = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].app_service_environments_v3, {}))
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
    application_gateway_platforms = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].application_gateway_platforms, {}))
    }
    application_gateway_applications_v1 = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].application_gateway_applications_v1, {}))
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
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].azure_container_registries, {}))
    }
    databricks_workspaces = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].databricks_workspaces, {}))
    }
    ddos_services = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].ddos_services, {}))
    }
    cosmos_dbs = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].cosmos_dbs, {}))
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
    domain_name_registrations = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].domain_name_registrations, {}))
    }
    event_hub_namespaces = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].event_hub_namespaces, {}))
    }
    express_route_circuit_authorizations = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].express_route_circuit_authorizations, {}))
    }
    express_route_circuits = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].express_route_circuits, {}))
    }
    express_route_circuit_peerings = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].express_route_circuit_peerings, {}))
    }
    front_door_waf_policies = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].front_door_waf_policies, {}))
    }
    integration_service_environment = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].integration_service_environment, {}))
    }
    keyvault_certificates = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].keyvault_certificates, {}))
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
    lb = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].lb, {}))
    }
    lb_backend_address_pool = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].lb_backend_address_pool, {}))
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
    signalr_services = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].signalr_services, {}))
    }
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
    mssql_managed_instances_secondary = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].mssql_managed_instances_secondary, {}))
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
    postgresql_flexible_servers = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].postgresql_flexible_servers, {}))
    }
    private_dns = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].private_dns, {}))
    }
    private_dns_resolvers = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].private_dns_resolvers, {}))
    }
    private_dns_resolver_inbound_endpoints = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].private_dns_resolver_inbound_endpoints, {}))
    }
    private_dns_resolver_outbound_endpoints = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].private_dns_resolver_outbound_endpoints, {}))
    }
    private_dns_resolver_dns_forwarding_rulesets = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].private_dns_resolver_dns_forwarding_rulesets, {}))
    }
    proximity_placement_groups = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].proximity_placement_groups, {}))
    }
    public_ip_addresses = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].public_ip_addresses, {}))
    }
    public_ip_prefixes = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].public_ip_prefixes, {}))
    }
    recovery_vaults = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].recovery_vaults, {}))
    }
    resource_groups = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].resource_groups, {}))
    }
    sentinel_watchlists = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].sentinel_watchlists, {}))
    }
    servicebus_namespaces = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].servicebus_namespaces, {}))
    }
    servicebus_topics = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].servicebus_topics, {}))
    }
    servicebus_queues = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].servicebus_queues, {}))
    }
    storage_accounts = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].storage_accounts, {}))
    }
    storage_containers = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].storage_containers, {}))
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
    virtual_machines = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].virtual_machines, {}))
    }
    virtual_subnets = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].virtual_subnets, {}))
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
    vmware_private_clouds = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].vmware_private_clouds, {}))
    }
    vmware_clusters = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].vmware_clusters, {}))
    }
    vmware_express_route_authorizations = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].vmware_express_route_authorizations, {}))
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
    image_definitions = {
      for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].image_definitions, {}))
    }
  }

}

# Map of the remote data state for lower level
variable lower_storage_account_name {}
variable lower_container_name {}
variable lower_resource_group_name {}

variable tfstate_subscription_id {
  description = "This value is propulated by the rover. subscription id hosting the remote tfstates"
}
variable tfstate_storage_account_name {}
variable tfstate_container_name {}
variable tfstate_key {}
variable tfstate_resource_group_name {}

variable landingzone {
  default = {
    backend_type = "azurerm"
    current = {
      level = "level2"
      key   = "networking_hub"
    }
    lower = {
      foundations = {
        tfstate = "caf_foundations.tfstate"
      }
      networking = {
        foundations = {
          tfstate = "caf_foundations.tfstate"
        }
      }
    }
  }
}
variable tenant_id {}

variable global_settings {
  default = {}
}
variable rover_version {}
variable logged_user_objectId {
  default = null
}
variable logged_aad_app_objectId {
  default = null
}
variable tags {
  type    = map
  default = {}
}
variable diagnostics_definition {
  default = null
}
variable resource_groups {
  default = {}
}
variable vnets {
  default = {}
}
variable virtual_wans {
  default = {}
}
variable public_ip_addresses {
  default = {}
}
variable vnet_peerings {
  default = {}
}
variable vhub_peerings {
  default = {}
}
variable azurerm_firewalls {
  default = {}
}
variable network_security_group_definition {
  default = null
}
variable route_tables {
  default = {}
}
variable azurerm_routes {
  default = {}
}
variable storage_accounts {
  default = {}
}
variable virtual_machines {
  default = {}
}
variable managed_identities {
  default = {}
}
variable azurerm_firewall_network_rule_collection_definition {
  default = {}
}
variable azurerm_firewall_application_rule_collection_definition {
  default = {}
}
variable azurerm_firewall_nat_rule_collection_definition {
  default = {}
}
variable azure_container_registries {
  default = {}
}
variable bastion_hosts {
  default = {}
}
variable ddos_services {
  default = {}
}
variable private_dns {
  default = {}
}
variable application_gateways {
  default = {}
}
variable application_gateway_applications {
  default = {}
}
variable keyvaults {
  default = {}
}
variable keyvault_access_policies {
  default = {}
}
variable express_route_circuits {
  default = {}
}
variable express_route_circuit_authorizations {
  default = {}
}
variable network_watchers {
  default = {}
}
variable private_endpoints {
  default = {}
}
variable dns_zones {
  default = {}
}
variable dns_zone_records {
  default = {}
}
variable virtual_network_gateways {
  default = {}
}
# Map of the remote data state for lower level
variable lowerlevel_storage_account_name {}
variable lowerlevel_container_name {}
variable lowerlevel_key {}
variable lowerlevel_resource_group_name {}

variable tfstate_storage_account_name {}
variable tfstate_container_name {}
variable tfstate_key {}
variable tfstate_resource_group_name {}

variable tfstates {
  default = {
    caf_foundations = {
      tfstate = "caf_foundations.tfstate"
    }
    caf_networking = {
      tfstate = "caf_networking.tfstate"
    }
  }
}

variable landingzone_name {
  description = "The landing zone name is used to reference the tfstate in configuration files. Therefore while set it is recommended not to change"
  default     = "networking"
}

variable global_settings {
  default = {}
}
variable rover_version {}
variable level {
  default = "level2"
}
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
  default = null
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
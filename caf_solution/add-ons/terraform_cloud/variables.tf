# Map of the remote data state for lower level
variable "lower_storage_account_name" {
  default = {}
}
variable "lower_container_name" {
  default = {}
}
variable "lower_resource_group_name" {
  default = {}
}

variable "tfstate_storage_account_name" {
  default = {}
}
variable "tfstate_container_name" {
  default = {}
}
variable "tfstate_key" {
  default = {}
}
variable "tfstate_resource_group_name" {
  default = {}
}

variable "global_settings" {
  default = {}
}
variable "tenant_id" {
  default = {}
}
variable "landingzone" {
  default = {}
}

variable "rover_version" {
  default = null
}

variable "logged_user_objectId" {
  default = null
}
variable "logged_aad_app_objectId" {
  default = null
}
variable "tags" {
  default = null
}
variable "keyvaults" {
  default = {}
}
variable "keyvault_access_policies" {
  default = {}
}
variable "role_mapping" {
  default = {}
}
variable "secrets_from_keys" {
  default = {}
}
variable "custom_role_definitions" {
  default = {}
}
variable "azuread_apps" {
  default = {}
}

variable "tfe_organizations" {
  default = {}
}

variable "tfe_workspaces" {
  default = {}
}

variable "tfe_variables" {
  default = {}
}

variable "tfe_variable_sets" {
  default = {}
}

variable "tfe_servers" {
  default = {}
}

variable "tfe_agent_pools" {
  default = {}
}

variable "tfe_agent_pool_tokens" {
  default = {}
}

variable "tfe_workspace_variable_sets" {
  default = {}
}

variable "tfe_notifications" {
  default = {}
}

variable "tfe_oauth_clients" {
  default = {}
}

variable "tfe_organization_memberships" {
  default = {}
}

variable "tfe_organization_module_sharings" {
  default = {}
}

variable "tfe_organization_tokens" {
  default = {}
}

variable "tfe_policy_sets" {
  default = {}
}

variable "tfe_sentinel_policies" {
  default = {}
}

variable "tfe_policy_set_parameters" {
  default = {}
}

variable "tfe_ssh_keys" {
  default = {}
}

variable "tfe_teams" {
  default = {}
}

variable "tfe_team_accesses" {
  default = {}
}

variable "tfe_team_organization_members" {
  default = {}
}
variable "tfe_team_members" {
  default = {}
}
variable "tfe_team_tokens" {
  default = {}
}

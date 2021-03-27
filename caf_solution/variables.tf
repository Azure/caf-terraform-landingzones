# Map of the remote data state for lower level
variable "lower_storage_account_name" {}
variable "lower_container_name" {}
variable "lower_resource_group_name" {}

variable "tfstate_subscription_id" {
  description = "This value is propulated by the rover. subscription id hosting the remote tfstates"
}
variable "tfstate_storage_account_name" {}
variable "tfstate_container_name" {}
variable "tfstate_key" {}
variable "tfstate_resource_group_name" {}

variable "landingzone" {}

variable "global_settings" {
  default = {}
}

variable "provider_azurerm_features_keyvault" {
  default = {
    purge_soft_delete_on_destroy = false
  }
}


variable "rover_version" {
  default = {}
}

variable "client_config" {
  default = {}
}

variable "tenant_id" {
  description = "Azure AD Tenant ID for the current deployment."
  default     = null
}

variable "current_landingzone_key" {
  description = "Key for the current landing zones where the deployment is executed. Used in the context of landing zone deployment."
  default     = "local"
  type        = string
}

variable "tfstates" {
  description = "Terraform states configuration object. Used in the context of landing zone deployment."
  default     = {}
}

variable "enable" {
  description = "Map of services defined in the configuration file you want to disable during a deployment."
  default = {
    # bastion_hosts    = true
    # virtual_machines = true
  }
}

variable "environment" {
  description = "Name of the CAF environment."
  type        = string
  default     = "sandpit"
}

variable "logged_user_objectId" {
  description = "Used to set access policies based on the value 'logged_in_user'. Can only be used in interactive execution with vscode."
  default     = null
}
variable "logged_aad_app_objectId" {
  description = "Used to set access policies based on the value 'logged_in_aad_app'"
  default     = null
}

variable "use_msi" {
  description = "Deployment using an MSI for authentication."
  default     = false
  type        = bool
}

variable "tags" {
  description = "Tags to be used for this resource deployment."
  type        = map(any)
  default     = null
}

variable "resource_groups" {
  description = "Resource groups configuration objects"
  default     = {}
}

variable "subscriptions" {
  default = {}
}

variable "subscription_billing_role_assignments" {
  default = {}
}

variable "billing" {
  description = "Billing information"
  default     = {}
}

variable "remote_objects" {
  description = "Remote objects is used to allow the landing zone to retrieve remote tfstate objects and pass them to the caf module"
  default     = {}
}

## Diagnostics settings
variable "diagnostics_definition" {
  default     = null
  description = "Shared diadgnostics settings that can be used by the services to enable diagnostics"
}

variable "diagnostics_destinations" {
  default = null
}

variable "log_analytics" {
  default = {}
}

variable "diagnostics" {
  default = {}
}

variable "event_hub_namespaces" {
  default = {}
}

variable "subnet_id" {
  default = {}
}

variable "user_type" {
  description = "The rover set this value to user or serviceprincipal. It is used to handle Azure AD api consents."
  default     = {}
}

## Azure AD
variable "azuread_apps" {
  default = {}
}

variable "azuread_groups" {
  default = {}
}

variable "azuread_roles" {
  default = {}
}

variable "azuread_users" {
  default = {}
}

variable "azuread_api_permissions" {
  default = {}
}

## Compute variables
variable "compute" {
  description = "Compute configuration objects"
  default = {
    virtual_machines = {}
  }
}

variable "webapp" {
  description = "Web applications configuration objects"
  default = {
    # app_services                 = {}
    # app_service_environments     = {}
    # app_service_plans            = {}
    # azurerm_application_insights = {}
  }
}


## Databases variables
variable "database" {
  description = "Database configuration objects"
  default     = {}
}


## Security variables
variable "security" {
  default = {}
}

variable "managed_identities" {
  description = "Managed Identity configuration objects"
  default     = {}
}

variable "keyvaults" {
  description = "Key Vault configuration objects"
  default     = {}
}

variable "keyvault_access_policies" {
  default = {}
}

variable "keyvault_access_policies_azuread_apps" {
  default = {}
}

variable "custom_role_definitions" {
  description = "Custom role definitions configuration objects"
  default     = {}
}
variable "role_mapping" {
  default = {
    built_in_role_mapping = {}
    custom_role_mapping   = {}
  }
}

variable "dynamic_keyvault_secrets" {
  default = {}
}

## Storage variables
variable "storage_accounts" {
  default = {}
}
variable "storage" {
  description = "Storage configuration objects"
  default     = {}
}
variable "diagnostic_storage_accounts" {
  default = {}
}


variable "keyvault_certificate_issuers" {
  default = {}
}
variable "cosmos_dbs" {
  default = {}
}
variable "event_hubs" {
  default = {}
}

variable "event_hub_auth_rules" {
  default = {}
}

variable "event_hub_namespace_auth_rules" {
  default = {}
}

variable "event_hub_consumer_groups" {
  default = {}
}

variable "diagnostic_event_hub_namespaces" {
  default = {}
}
variable "diagnostic_log_analytics" {
  default = {}
}
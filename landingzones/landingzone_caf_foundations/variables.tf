# Map of the remote data state filled by the rover at runtime
variable lowerlevel_storage_account_name {}
variable lowerlevel_container_name {}
variable lowerlevel_key {} # Keeping the key for the lower level0 access
variable lowerlevel_resource_group_name {}


# Set of variables for the CAF foundations landing zone
variable tags {
  type    = map
  default = {}
}

variable global_settings {
  description = "(Required) object describing global settings for landing zone configuration (region, naming convention etc.)"
}

variable accounting_settings {
  description = "(Required) object describing accounting settings for landing zone configuration (azure monitor log analytics, storage accounts, etc.)"
}
variable security_settings {
  description = "(Required) object describing security settings for landing zone configuration (azure security center standard, azure sentinel enablement.)"
}
variable governance_settings {
  description = "(Required) object describing governance settings for landing zone configuration (azure policies and azure management groups)"
}

variable prefix {
  description = "(Optional) By default CAF Foundation gets the prefix from the launchpad. You can overwride it by setting a value."
  default     = null
}
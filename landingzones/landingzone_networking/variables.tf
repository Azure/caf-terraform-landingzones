# Map of the remote data state for lower level
variable lowerlevel_storage_account_name {}
variable lowerlevel_container_name {}
variable lowerlevel_key {} # Keeping the key for the lower level0 access
variable lowerlevel_resource_group_name {}
variable workspace {}

variable tags {
  type    = map
  default = {}
}

variable vnets {
  description = "Map of vnet objects"
}

variable peerings {
  description = "(Optional) Map of peering objects"
  default     = {}
}

variable firewalls {
  description = "(Optional) Map of firewall objects"
  default     = {}
}

variable bastions {
  description = "(Optional) Map of Azure Bastions objects"
  default     = {}
}

variable vwans {
  description = "(Optional) Map of virtual wan objects"
  default     = {}
}

variable ddos_services {
  description = "(Optional) Map of ddos objects"
  default     = {}
}

variable route_tables {
  description = "(Optional) User define route object"
  default     = {}
}

variable resource_groups {}

variable diagnostics {
  default = {
    vnet = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
        ["VMProtectionAlerts", true, true, 60],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]                 
        ["AllMetrics", true, true, 60],
      ]
    }
  }
}
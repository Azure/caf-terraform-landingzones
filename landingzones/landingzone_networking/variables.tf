# Map of the remote data state for lower level
variable "lowerlevel_storage_account_name" {}
variable "lowerlevel_container_name" {}
variable "lowerlevel_key" {} # Keeping the key for the lower level0 access
variable "lowerlevel_resource_group_name" {}
variable "workspace" {}

variable "tags" {
  type    = map
  default = {}
}

variable vnets {
  description = "Map of vnet objects"
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
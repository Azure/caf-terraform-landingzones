variable lowerlevel_storage_account_name {}
variable lowerlevel_container_name {}
variable lowerlevel_resource_group_name {}
variable lowerlevel_key {}


variable tags {
    default = {}
    type = map
}


variable "storage_account_name" {
    description = "Storage account name to store diagnostics and Azure DevOps init script"
    default = ""
}

variable "disk_encryption_set_id" {
    description = "(Optional) The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk."
    type = string
    default = null
}

variable "private_key_pem_file" {
    description = "(Optional) Name of the public key file name. A local key will be created if not provided"
    default = ""
}

variable vm_object {}

variable azure_devops {}

variable rover_version {
    description = "(default=aztfmod/roverdev:vnext) Version of the rover to use on the Azure Devops self-hosted agents"
    default = "aztfmod/roverdev:vnext"
}
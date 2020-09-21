
resource "azurerm_virtual_machine_extension" "devops_selfhosted_agent" {
  for_each = {
    for key, value in var.extensions : key => value
    if key == "devops_selfhosted_agent"
  }

  name = "install_azure_devops_agent"

  virtual_machine_id   = var.virtual_machine_id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.1"

  #timestamp: use this field only to trigger a re-run of the script by changing value of this field.
  #           Any integer value is acceptable; it must only be different than the previous value.
  settings = jsonencode(
    {
      "timestamp" : "${each.value.version}"
    }
  )
  protected_settings = jsonencode(
    {
      "fileUris" : "${local.devops_selfhosted_agent.file_uris}",
      "commandToExecute" : "${format("bash %s '%s' '%s' '%s' '%s' '%s' '%s' '%s'", var.extensions["devops_selfhosted_agent"].agent_init_script, var.settings["devops_selfhosted_agent"].azure_devops.url, var.settings["devops_selfhosted_agent"].agent_pat, var.settings["devops_selfhosted_agent"].azure_devops.organization_agent_pools[each.value.agent_pool_key].name, var.settings["devops_selfhosted_agent"].azure_devops.organization_agent_pools[each.value.agent_pool_key].agent_name_prefix, var.settings["devops_selfhosted_agent"].azure_devops.organization_agent_pools[each.value.agent_pool_key].num_agents, var.settings["devops_selfhosted_agent"].admin_username, var.settings["devops_selfhosted_agent"].azure_devops.rover_version)}"
    }
  )

}

locals {
  devops_selfhosted_agent = {
    file_uris = flatten(
      [
        for file_uris_key, file in try(var.extensions.devops_selfhosted_agent.fileUris, {}) : [
          for file_uri_key in file.storage_blob_keys : var.settings.devops_selfhosted_agent.storage_accounts[file.storage_account_key].containers[file.container_key].blobs[file_uri_key].url
        ]
      ]
    )
  }
}

resource "azurerm_virtual_machine_extension" "gha_runner" {
  for_each = {
    for key, value in var.extensions : key => value
    if key == "gha_runner"
  }

  name                 = "install_gha_runner"
  virtual_machine_id   = var.virtual_machine_id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.1"

  # Change the value of timestamp to trigger a rerun of the extension. Any integer value is
  # acceptable; it must only be different than the previous value.
  settings = jsonencode(
    {
      "timestamp" : each.value.version,
      "fileUris" : concat(local.gha_runner.file_uris, local.gha_runner.storage_account_blobs_urls),
    }
  )

  protected_settings = jsonencode(
    {
      "commandToExecute" : format(
        "bash '%s' '%s' '%s' '%s' '%s' '%s'",
        var.extensions[each.key].runner_init_script,
        var.settings[each.key].gha_runner.gh_org,
        var.settings[each.key].token,
        join("-", concat(var.global_settings.prefixes, [var.settings[each.key].gha_runner.runner_name_prefix])),
        var.settings[each.key].admin_username,
        var.settings[each.key].gha_runner.num_runners,
      )
    }
  )
}

# Unregister the runners from Github on destroy to avoid proliferation of stale runners.
resource "null_resource" "remove_runner" {
  for_each = {
    for key, value in var.extensions : key => value
    if key == "gha_runner"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "go run remove_runner.go"
    working_dir = "scripts/remove_runner"
    environment = {
      GH_RUNNER_PREFIX = self.triggers.GH_RUNNER_PREFIX
      GH_ORG = self.triggers.GH_ORG
      GH_TOKEN = self.triggers.GH_TOKEN
      GH_NUM_RUNNERS = self.triggers.GH_NUM_RUNNERS
    }
  }

  # Triggers are used here due to limitations in Terraform on passing vars to local-exec/destroy
  triggers = {
    GH_RUNNER_PREFIX = join("-", concat(var.global_settings.prefixes, [var.settings[each.key].gha_runner.runner_name_prefix]))
    GH_ORG = var.settings[each.key].gha_runner.gh_org
    GH_TOKEN = var.settings[each.key].token
    GH_NUM_RUNNERS = var.settings[each.key].gha_runner.num_runners
  }
}

locals {
  gha_runner = {
    file_uris = flatten(
      [
        for file_uris_key, file in try(var.extensions.gha_runner.fileUris, {}) : [
          for file_uri_key in file.storage_blob_keys : var.settings.gha_runner.storage_accounts[file.storage_account_key].containers[file.container_key].blobs[file_uri_key].url
        ]
      ]
    )

    storage_account_blobs_urls = try(var.settings.gha_runner.storage_account_blobs_urls, [])
  }
}

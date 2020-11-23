keyvaults = {
  aml_secrets = {
    name                = "amlsecrets"
    resource_group_key  = "azure_ml"
    sku_name            = "premium"
    soft_delete_enabled = true
  }
}
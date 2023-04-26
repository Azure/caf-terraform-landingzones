locals {
  data_protection = merge(
    var.data_protection,
    {
      backup_vaults          = var.backup_vaults
      backup_vault_policies  = var.backup_vault_policies
      backup_vault_instances = var.backup_vault_instances
    }
  )
}

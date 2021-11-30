data "azuredevops_users" "user" {
  for_each = toset(var.group_settings.members.user_principal_names)

  principal_name = each.value
}

resource "azuredevops_group_membership" "membership" {
  group   = var.group_descriptor
  members = flatten(values(data.azuredevops_users.user)[*].users[*].descriptor)
}

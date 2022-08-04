
resource "tfe_organization" "tfe_org" {
  for_each = try(var.tfe_organizations, {})

  name                     = each.value.name
  email                    = each.value.email
  session_timeout_minutes  = try(each.value.session_timeout_minutes, 20160)
  session_remember_minutes = try(each.value.session_remember_minutes, 20160)
  collaborator_auth_policy = try(each.value.collaborator_auth_policy, "password")
  owners_team_saml_role_id = try(each.value.owners_team_saml_role_id, null)
}

resource "tfe_workspace" "tfe_wks" {
  for_each = try(var.tfe_workspaces, {})

  name                  = each.value.name
  organization          = tfe_organization.tfe_org[each.value.organization_key].name
  auto_apply            = try(each.value.auto_apply, false)
  file_triggers_enabled = try(each.value.file_triggers_enabled, true)
  operations            = try(each.value.operations, true)
  queue_all_runs        = try(each.value.queue_all_runs, true)
  speculative_enabled   = try(each.value.speculative_enabled, true)
  ssh_key_id            = try(each.value.ssh_key_id, null)
  terraform_version     = try(each.value.terraform_version, null)
  trigger_prefixes      = try(each.value.trigger_prefixes, null)
  working_directory     = try(each.value.working_directory, null)

  dynamic "vcs_repo" {
    for_each = lookup(each.value, "vcs_repo", null) == null ? [] : [1]

    content {
      identifier         = each.value.vcs_repo.identifier
      branch             = try(each.value.vcs_repo.branch, null)
      ingress_submodules = try(each.value.vcs_repo.ingress_submodules, false)
      oauth_token_id     = each.value.vcs_repo.oauth_token_id
    }
  }
}

resource "tfe_variable" "variable" {
  for_each = try(var.tfe_variables, {})

  key          = each.value.key_name
  value        = each.value.value
  category     = each.value.category
  workspace_id = tfe_workspace.tfe_wks[each.value.workspace_key].id
  description  = each.value.description
  hcl          = try(each.value.hcl, false)
  sensitive    = try(each.value.sensitive, false)
}

resource "null_resource" "backend_file" {
  depends_on = [tfe_workspace.tfe_wks]
  for_each   = try(var.tfe_workspaces, {})

  provisioner "local-exec" {
    working_dir = "./"
    command     = "echo workspaces '{' name = \\\"${each.value.name}\\\" '}' >> ${path.cwd}${each.value.backend_file}"
  }
  provisioner "local-exec" {
    working_dir = "./"
    command     = "echo hostname = \\\"app.terraform.io\\\" >> ${path.cwd}${each.value.backend_file}"
  }
  provisioner "local-exec" {
    working_dir = "./"
    command     = "echo organization = \\\"${tfe_organization.tfe_org[each.value.organization_key].name}\\\" >> ${path.cwd}${each.value.backend_file}"
  }
}

resource "null_resource" "backend_file_destroy" {
  depends_on = [tfe_workspace.tfe_wks]
  for_each   = try(var.tfe_workspaces, {})

  triggers = {
    backend_file = lookup(each.value, "backend_file")
  }

  provisioner "local-exec" {
    command    = format("rm %s%s", path.cwd, self.triggers.backend_file)
    when       = destroy
    on_failure = fail
  }
}


resource "tfe_agent_pool" "tfe_agent_pools" {
  depends_on = [tfe_organization.tfe_org]
  for_each   = try(var.tfe_agent_pools, {})

  name         = each.value.name
  organization = try(each.value.organization_name, tfe_organization.tfe_org[each.value.organization_key].name)
}

resource "tfe_agent_token" "tfe_agent_pool_tokens" {
  depends_on = [tfe_agent_pool.tfe_agent_pools]
  for_each   = try(var.tfe_agent_pool_tokens, {})

  agent_pool_id = try(each.value.agent_pool_id, tfe_agent_pool.tfe_agent_pools[each.value.agent_pool_key].id)
  description   = each.value.description
}

#TODO: keyvault to store the tfe agent pools, data source?


resource "tfe_variable_set" "tfe_varsets" {
  depends_on = [tfe_workspace.tfe_wks]
  for_each   = try(var.tfe_variable_sets, {})

  name         = each.value.name
  description  = try(each.value.description, null)
  organization = try(each.value.organization.name, tfe_organization.tfe_org[each.value.organization.key].name)
}

# resource "tfe_workspace_variable_set" "tfe_wks_varsets" { # > v 0.33.0
#   for_each = try(var.tfe_workspace_variable_sets, {})

#   workspace_id    = tfe_workspace.tfe_wks[each.value.workspace.key].id
#   variable_set_id = tfe_variable_set.tfe_varsets[each.value.variable_set.key].id

# }

resource "tfe_notification_configuration" "tfe_notifications" {
  for_each = try(var.tfe_notifications, {})

  name             = each.value.name
  enabled          = each.value.enabled
  destination_type = each.value.destination_type
  email_user_ids   = try(each.value.email_user_ids, null)
  email_addresses  = try(each.value.email_addresses, null)
  triggers         = try(each.value.triggers, null)
  url              = try(each.value.url, null)
  workspace_id     = try(each.value.workspace_id, tfe_workspace.tfe_wks[each.value.workspace.key].id)

}

resource "tfe_oauth_client" "tfe_oauth_clients" {
  for_each = try(var.tfe_oauth_clients, {})

  name             = each.value.name
  organization     = try(each.value.organization.name, tfe_organization.tfe_org[each.value.organization.key].name)
  api_url          = each.value.api_url
  http_url         = each.value.http_url
  oauth_token      = try(each.value.oauth_token, null)
  private_key      = try(each.value.private_key, null)
  key              = try(each.value.key, null)
  secret           = try(each.value.secret, null)
  rsa_public_key   = try(each.value.rsa_public_key, null)
  service_provider = each.value.service_provider
}

resource "tfe_organization_membership" "tfe_org_memberships" {
  depends_on = [tfe_organization.tfe_org]

  for_each = try(var.tfe_organization_memberships, {})

  organization = try(each.value.organization.name, tfe_organization.tfe_org[each.value.organization.key].name)
  email        = each.value.email
}

resource "tfe_organization_module_sharing" "tfe_organization_module_sharings" {
  for_each = try(var.tfe_organization_module_sharings, {})

  organization     = try(each.value.organization.name, tfe_organization.tfe_org[each.value.organization.key].name)
  module_consumers = each.value.module_consumers
}

resource "tfe_organization_token" "tfe_org_tokens" {
  for_each = try(var.tfe_organization_tokens, {})

  organization = try(each.value.organization.name, tfe_organization.tfe_org[each.value.organization.key].name)
}

# TODO: output and store token in azure keyvault

locals {
  policy_set_sentinel_policy_ids = flatten([
    for key, value in try(var.tfe_policy_sets, []) : [
      for policy_key in try(value.policy.keys, []) : [
        tfe_sentinel_policy.tfe_sentinel_policies[policy_key].id
      ]
    ]
  ])
  policy_set_workspace_ids = flatten([
    for key, value in try(var.tfe_policy_sets, []) : [
      for workspace_key in try(value.workspace.keys, []) : [
        tfe_workspace.tfe_wks[workspace_key].id
      ]
    ]
  ])
}

resource "tfe_policy_set" "tfe_policy_sets" {
  depends_on = [tfe_workspace.tfe_wks, tfe_sentinel_policy.tfe_sentinel_policies]
  for_each   = try(var.tfe_policy_sets, {})

  name          = each.value.name
  description   = try(each.value.description, null)
  global        = try(each.value.global, null)
  organization  = try(each.value.organization.name, tfe_organization.tfe_org[each.value.organization.key].name)
  policy_ids    = try(each.value.policy.ids, local.policy_set_sentinel_policy_ids, null)
  workspace_ids = try(each.value.workspace.ids, local.policy_set_workspace_ids, null)

  dynamic "vcs_repo" {
    for_each = try(each.value.vcs_repo, null) != null ? [1] : []

    content {
      identifier         = each.value.vcs_repo.identifier
      branch             = try(each.value.vcs_repo.branch, null)
      ingress_submodules = try(each.value.vcs_repo.ingress_submodules, null)
      oauth_token_id     = try(each.value.vcs_repo.oauth_token_id, tfe_oauth_client.tfe_oauth_clients[each.value.vcs_repo.oauth_token_key].id)
    }
  }

}

resource "tfe_sentinel_policy" "tfe_sentinel_policies" {
  depends_on = [tfe_organization.tfe_org]

  for_each = try(var.tfe_sentinel_policies, {})

  name         = each.value.name
  description  = try(each.value.description, null)
  organization = try(each.value.organization.name, tfe_organization.tfe_org[each.value.organization.key].name)
  policy       = each.value.policy
  enforce_mode = each.value.enforce_mode
}

resource "tfe_policy_set_parameter" "tfe_policy_set_parameters" {
  for_each = try(var.tfe_policy_set_parameters, {})

  key           = each.value.key
  value         = each.value.value
  policy_set_id = try(each.value.policy_set.id, tfe_policy_set.tfe_policy_sets[each.value.policy_set.key].id)
}

resource "tfe_ssh_key" "tfe_ssh_keys" {
  for_each = try(var.tfe_ssh_keys, {})

  name         = each.value.name
  organization = try(each.value.organization.name, tfe_organization.tfe_org[each.value.organization.key].name)
  key          = try(each.value.ssh_private_key, null) #TODO: add support for keyvault
}

resource "tfe_team" "tfe_teams" {
  for_each = try(var.tfe_teams, {})

  name         = each.value.name
  organization = try(each.value.organization.name, tfe_organization.tfe_org[each.value.organization.key].name)

  dynamic "organization_access" {
    for_each = try(each.value.organization_access, null) != null ? [1] : []

    content {
      manage_policies         = try(organization_access.value.manage_policies, null)
      manage_policy_overrides = try(organization_access.value.manage_policy_overrides, null)
      manage_workspaces       = try(organization_access.value.manage_workspaces, null)
      manage_vcs_settings     = try(organization_access.value.manage_vcs_settings, null)
      manage_providers        = try(organization_access.value.manage_providers, null)
      manage_modules          = try(organization_access.value.manage_modules, null)
      manage_run_tasks        = try(organization_access.value.manage_run_tasks, null)
    }
  }

}

resource "tfe_team_access" "tfe_team_accesses" {
  for_each = try(var.tfe_team_accesses, {})

  access       = try(each.value.access, null)
  team_id      = try(each.value.team.id, tfe_team.tfe_teams[each.value.team.key].id)
  workspace_id = try(each.value.workspace.id, tfe_workspace.tfe_wks[each.value.workspace.key].id)

  dynamic "permissions" {
    for_each = try(each.value.permissions, null) != null ? [1] : []

    content {
      runs              = each.value.permissions.runs
      variables         = each.value.permissions.variables
      state_versions    = each.value.permissions.state_versions
      sentinel_mocks    = each.value.permissions.sentinel_mocks
      workspace_locking = each.value.permissions.workspace_locking
      run_tasks         = each.value.permissions.run_tasks
    }
  }
}

resource "tfe_team_organization_member" "tfe_team_organization_members" {
  for_each = try(var.tfe_team_organization_members, {})

  team_id      = try(each.value.team.id, tfe_team.tfe_teams[each.value.team.key].id)
  organization_membership_id = try(each.value.organization_membership.id, tfe_organization_membership.tfe_org_memberships[each.value.organization_membership.key].id)
  
}

resource "tfe_team_members" "tfe_team_members" {
  for_each = try(var.tfe_team_members, {})

  team_id      = try(each.value.team.id, tfe_team.tfe_teams[each.value.team.key].id)
  usernames    = each.value.usernames
}

resource "tfe_team_token" "tfe_team_tokens" {
  for_each     = try(var.tfe_team_tokens, {})
  
  team_id      = try(each.value.team.id, tfe_team.tfe_teams[each.value.team.key].id)
}
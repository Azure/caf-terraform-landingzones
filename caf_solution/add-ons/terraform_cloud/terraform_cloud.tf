
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
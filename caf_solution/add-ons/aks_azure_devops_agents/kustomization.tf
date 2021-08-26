data "kustomization_overlay" "manifest" {
  for_each = var.kustomization_overlays

  resources = each.value.resources

  namespace = each.value.namespace

  dynamic "patches" {
    for_each = try(each.value.patches, {})
    content {
      patch  = patches.value.patch
      target = patches.value.target
    }
  }
  # kustomize_options = {
  #   load_restrictor = "none"
  # }
}

output "manifests" {
  value = data.kustomization_overlay.manifest
}


module "kustomization_azdopat-secret" {
  for_each = var.keyvaults
  source   = "../aks_applications/kustomize"

  settings = data.kustomization_overlay.azdopat-secret[each.key]

}

data "kustomization_overlay" "azdopat-secret" {
  for_each = var.keyvaults
  resources = [
    "yamls/akvs-secret.yaml",
  ]

  namespace = var.agent_pools.namespace

  patches {
    patch = <<-EOF
      - op: replace
        path: /spec/vault/name
        value: "${local.remote.keyvaults[each.value.lz_key][each.value.key].name}"
    EOF
    target = {
      kind = "AzureKeyVaultSecret"
    }
  }

  patches {
    patch = <<-EOF
      - op: replace
        path: /spec/vault/object/name
        value: "${each.value.secret_name}"
    EOF
    target = {
      kind = "AzureKeyVaultSecret"
    }
  }

  patches {
    patch = <<-EOF
      - op: replace
        path: /metadata/name
        value: "${each.key}-${each.value.secret_name}"
    EOF
    target = {
      kind = "AzureKeyVaultSecret"
    }
  }

  patches {
    patch = <<-EOF
      - op: replace
        path: /spec/output/secret/name
        value: "${each.key}-${each.value.secret_name}"
    EOF
    target = {
      kind = "AzureKeyVaultSecret"
    }
  }

}

module "kustomization" {
  source   = "../aks_applications/kustomize"
  for_each = try(data.kustomization_overlay.roverjob, {})

  settings = each.value

}
data "kustomization_overlay" "roverjob" {
  for_each = local.filtered_agent_pools

  resources = [
    "yamls/roverjob.yaml",
  ]

  namespace = var.agent_pools.namespace

  patches {
    patch = <<-EOF
      - op: replace
        path: /metadata/name
        value: "azdevops-${replace(each.key, "_", "-")}"
    EOF
    target = {
      kind = "ScaledJob"
    }
  }

  patches {
    patch = <<-EOF
      - op: replace
        path: /spec/jobTargetRef/template/metadata/labels/aadpodidbinding
        value: ${local.remote.managed_identities[var.agent_pools.agents[each.key].lz_key][var.agent_pools.agents[each.key].msi_key].name}
    EOF
    target = {
      kind = "ScaledJob"
    }
  }

  patches {
    patch = <<-EOF
      - op: replace
        path: /spec/jobTargetRef/template/spec/containers/0/env/0/value
        value: ${var.agent_pools.org_url}
    EOF
    target = {
      kind = "ScaledJob"
    }
  }

  patches {
    patch = <<-EOF
      - op: replace
        path: /spec/jobTargetRef/template/spec/containers/0/env/1/valueFrom/secretKeyRef/name
        value: "${var.agent_pools.keyvault_key}-${var.keyvaults[var.agent_pools.keyvault_key].secret_name}"
    EOF
    target = {
      kind = "ScaledJob"
    }
  }

  patches {
    patch = <<-EOF
      - op: replace
        path: /spec/jobTargetRef/template/spec/containers/0/env/2/value
        value: ${each.value.name}
    EOF
    target = {
      kind = "ScaledJob"
    }
  }

  patches {
    patch = <<-EOF
      - op: replace
        path: /spec/jobTargetRef/template/spec/containers/0/image
        value: "${var.agent_pools.image}"
    EOF
    target = {
      kind = "ScaledJob"
    }
  }

  patches {
    patch = <<-EOF
      - op: replace
        path: /spec/triggers/0/metadata/poolID
        value: "${each.value.id}"
    EOF
    target = {
      kind = "ScaledJob"
    }
  }
}


module "kustomization_placeholderagent" {
  source   = "../aks_applications/kustomize"
  for_each = try(data.kustomization_overlay.placeholderjob, {})

  settings = each.value

}

data "kustomization_overlay" "placeholderjob" {
  for_each = local.filtered_agent_pools

  resources = [
    "yamls/placeholderjob.yaml",
  ]

  namespace = var.agent_pools.namespace

  patches {
    patch = <<-EOF
      - op: replace
        path: /metadata/name
        value: "placeholder-job-${replace(each.key, "_", "-")}"
    EOF
    target = {
      kind = "Job"
    }
  }

  patches {
    patch = <<-EOF
      - op: replace
        path: /spec/template/spec/containers/0/env/0/value
        value: ${var.agent_pools.org_url}
    EOF
    target = {
      kind = "Job"
    }
  }

  patches {
    patch = <<-EOF
      - op: replace
        path: /spec/template/spec/containers/0/env/1/valueFrom/secretKeyRef/name
        value: "${var.agent_pools.keyvault_key}-${var.keyvaults[var.agent_pools.keyvault_key].secret_name}"
    EOF
    target = {
      kind = "Job"
    }
  }

  patches {
    patch = <<-EOF
      - op: replace
        path: /spec/template/metadata/labels/aadpodidbinding
        value: ${local.remote.managed_identities[var.agent_pools.agents[each.key].lz_key][var.agent_pools.agents[each.key].msi_key].name}
    EOF
    target = {
      kind = "Job"
    }
  }

  patches {
    patch = <<-EOF
      - op: replace
        path: /spec/template/spec/containers/0/env/2/value
        value: ${each.value.name}
    EOF
    target = {
      kind = "Job"
    }
  }

  patches {
    patch = <<-EOF
      - op: replace
        path: /spec/template/spec/containers/0/image
        value: "${var.agent_pools.image}"
    EOF
    target = {
      kind = "Job"
    }
  }
}

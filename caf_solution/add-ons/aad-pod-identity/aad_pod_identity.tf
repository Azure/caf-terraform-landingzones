# https://github.com/Azure/aad-pod-identity/blob/b3ee1d07209f26c47a96abf3ba20749932763de6/website/content/en/docs/Concepts/azureidentity.md

resource "kubernetes_namespace" "ns" {
  count = var.aad_pod_identity.namespace != {} && try(var.aad_pod_identity.create, true) ? 1 : 0

  metadata {
    name = var.aad_pod_identity.namespace
  }
}

module "build" {
  depends_on = [kubernetes_namespace.ns]
  source     = "./build"
  for_each   = try(data.kustomization_overlay.aad_pod_identity, {})

  settings = each.value
}



data "kustomization_overlay" "aad_pod_identity" {
  for_each = local.msi

  resources = [
    "aad-msi-binding.yaml",
  ]

  namespace = var.aad_pod_identity.namespace

  patches {
    patch = <<-EOF
      - op: replace
        path: /spec/resourceID
        value: ${each.value.id}
    EOF

    target = {
      kind = "AzureIdentity"
    }
  }

  patches {
    patch = <<-EOF
      - op: replace
        path: /spec/clientID
        value: ${each.value.client_id}
    EOF

    target = {
      kind = "AzureIdentity"
    }
  }

  patches {
    patch = <<-EOF
      - op: replace
        path: /metadata/name
        value: ${each.value.pod_aad_name}
    EOF

    target = {
      kind = "AzureIdentity"
    }
  }

  patches {
    patch = <<-EOF
      - op: replace
        path: /metadata/name
        value: ${each.value.pod_aad_name}
    EOF

    target = {
      kind = "AzureIdentityBinding"
    }
  }

  patches {
    patch = <<-EOF
      - op: replace
        path: /spec/azureIdentity
        value: ${each.value.pod_aad_name}
    EOF

    target = {
      kind = "AzureIdentityBinding"
    }
  }

  patches {
    patch = <<-EOF
      - op: replace
        path: /spec/selector
        value: ${each.value.pod_aad_name}
    EOF

    target = {
      kind = "AzureIdentityBinding"
    }
  }
}

locals {
  msi = {
    for msi in flatten(
      [
        for key, value in var.managed_identities : [
          for msi_key in value.msi_keys : {
            key       = key
            lz_key    = value.lz_key
            msi_key   = msi_key
            client_id = local.remote.managed_identities[value.lz_key][msi_key].client_id
            id        = local.remote.managed_identities[value.lz_key][msi_key].id
            name      = local.remote.managed_identities[value.lz_key][msi_key].name
            pod_aad_name  = local.remote.managed_identities[value.lz_key][msi_key].name
          }
        ]
      ]
    ) : format("%s-%s", msi.key, msi.msi_key) => msi
  }
}

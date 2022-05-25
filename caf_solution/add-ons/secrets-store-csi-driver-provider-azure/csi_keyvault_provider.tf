resource "kubernetes_namespace" "ns" {
  count = var.csi_keyvault_provider.namespace != {} && try(var.csi_keyvault_provider.create, true) ? 1 : 0

  metadata {
    name = var.csi_keyvault_provider.namespace
  }
}

module "build" {
  depends_on = [kubernetes_namespace.ns]
  source     = "./build"
  settings   = data.kustomization_overlay.csi_keyvault_provider
}

data "kustomization_overlay" "csi_keyvault_provider" {
  resources = [
    "secretproviderclass.yaml",
  ]

  namespace = var.csi_keyvault_provider.namespace

  patches {
    patch = <<-EOF
      - op: replace
        path: /metadata/name
        value: ${var.csi_keyvault_provider.secretproviderclass_name}
    EOF

    target = {
      kind = "SecretProviderClass"
    }
  }

  patches {
    patch = <<-EOF
      - op: replace
        path: /spec/secretObjects/0/secretName
        value: ${var.csi_keyvault_provider.secret_name}
    EOF

    target = {
      kind = "SecretProviderClass"
    }
  }

  patches {
    patch = <<-EOF
      - op: replace
        path: /spec/secretObjects/0/data/0/objectName
        value: ${var.csi_keyvault_provider.cert_name}
    EOF

    target = {
      kind = "SecretProviderClass"
    }
  }

  patches {
    patch = <<-EOF
      - op: replace
        path: /spec/secretObjects/0/data/1/objectName
        value: ${var.csi_keyvault_provider.cert_name}
    EOF

    target = {
      kind = "SecretProviderClass"
    }
  }

  patches {
    patch = <<-EOF
      - op: replace
        path: /spec/parameters/keyvaultName
        value: ${local.keyvault_name}
    EOF

    target = {
      kind = "SecretProviderClass"
    }
  }

  patches {
    patch = <<-EOF
      - op: replace
        path: /spec/parameters/objects
        value: |
          array:
            - |
              objectName: ${var.csi_keyvault_provider.cert_name}
              objectType: secret
    EOF

    target = {
      kind = "SecretProviderClass"
    }
  }

  patches {
    patch = <<-EOF
      - op: replace
        path: /spec/parameters/tenantId
        value: ${try(var.csi_keyvault_provider.keyvault_tenant_id, data.azurerm_client_config.current.tenant_id)}
    EOF

    target = {
      kind = "SecretProviderClass"
    }
  }
}

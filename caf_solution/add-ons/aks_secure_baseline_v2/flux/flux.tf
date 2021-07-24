data "flux_install" "main" {
  target_path = var.setting.target_path
  namespace   = var.setting.namespace
}

data "flux_sync" "main" {
  target_path = var.setting.target_path
  url         = var.setting.url
  branch      = var.setting.branch
  secret      = try(var.setting.flux_auth_secret, null)
  namespace   = var.setting.namespace
}

data "kubectl_file_documents" "install" {
  content = data.flux_install.main.content
}

data "kubectl_file_documents" "sync" {
  content = data.flux_sync.main.content
}

locals {
  install = [for v in data.kubectl_file_documents.install.documents : {
    data : yamldecode(v)
    content : v
    }
  ]
  sync = [for v in data.kubectl_file_documents.sync.documents : {
    data : yamldecode(v)
    content : v
    }
  ]
}

resource "kubectl_manifest" "install" {
  for_each   = { for v in local.install : lower(join("/", compact([v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name]))) => v.content }
  yaml_body  = each.value
}

resource "kubectl_manifest" "sync" {
  for_each   = { for v in local.sync : lower(join("/", compact([v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name]))) => v.content }
  depends_on = [kubectl_manifest.install]
  yaml_body  = each.value
}



resource "kubernetes_secret" "fluxauth" {
  depends_on = [kubectl_manifest.install]

  metadata {
    name      = try(var.setting.flux_auth_secret, "flux-system")
    namespace = var.setting.namespace
  }
  data = try(var.setting.secret.data, null)
  type = try(var.setting.secret.type, null)
}


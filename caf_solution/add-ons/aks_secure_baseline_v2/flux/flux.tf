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

resource "kubernetes_namespace" "flux_system" {
  metadata {
    name = var.setting.namespace
  }

  lifecycle {
    ignore_changes = [
      metadata[0].labels, metadata[0].annotations
    ]
  }
}

locals {
  flux_install_yaml_documents_without_namespace = [for x in data.kubectl_file_documents.install.documents : x if length(regexall("kind: Namespace", x)) == 0]
  install = [for v in local.flux_install_yaml_documents_without_namespace : {
    data : yamldecode(v)
    content : v
    }
  ]
  flux_sync_yaml_without_secret = [for x in data.kubectl_file_documents.sync.documents : (length(regexall("kind: GitRepository", x)) == 0) ? x : replace(x, "/\n.*(secretRef:)\n.*(name: flux-system)/", "")]

  sync = [for v in can(var.setting.secret.data) ? data.kubectl_file_documents.sync.documents : local.flux_sync_yaml_without_secret : {
    data : yamldecode(v)
    content : v
    }
  ]
}

resource "kubectl_manifest" "install" {
  for_each   = { for v in local.install : lower(join("/", compact([v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name]))) => v.content }
  depends_on = [kubernetes_namespace.flux_system]
  yaml_body  = each.value
}

resource "kubectl_manifest" "sync" {
  for_each   = { for v in local.sync : lower(join("/", compact([v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name]))) => v.content }
  depends_on = [kubernetes_namespace.flux_system, kubectl_manifest.install]
  yaml_body  = each.value
}



resource "kubernetes_secret" "fluxauth" {
  count      = can(var.setting.secret.data) ? 1 : 0
  depends_on = [kubectl_manifest.install]

  metadata {
    name      = try(var.setting.flux_auth_secret, "flux-system")
    namespace = var.setting.namespace
  }
  data = try(var.setting.secret.data, null)
  type = try(var.setting.secret.type, null)
}


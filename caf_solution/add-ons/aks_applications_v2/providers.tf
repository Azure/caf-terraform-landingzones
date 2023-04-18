provider "azurerm" {
  partner_id = "ca4078f8-9bc4-471b-ab5b-3af6b86a42c8"
  # partner identifier for CAF Terraform landing zones.
  features {
  }
}

provider "kubernetes" {
  host                   = yamldecode(data.azurerm_kubernetes_cluster.kubeconfig.kube_config_raw).clusters[0].cluster.server
  cluster_ca_certificate = base64decode(yamldecode(data.azurerm_kubernetes_cluster.kubeconfig.kube_config_raw).clusters[0].cluster.certificate-authority-data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "/usr/local/bin/kubelogin"
    args = [
      "get-token",
      "--login",
      "spn",
      "--environment",
      "AzurePublicCloud",
      "--tenant-id",
      data.azurerm_key_vault_secret.tenant_id.value,
      "--server-id",
      yamldecode(data.azurerm_kubernetes_cluster.kubeconfig.kube_config_raw).users[0].user.exec.args[4],
      "--client-id",
      data.azurerm_key_vault_secret.client_id.value,
      "--client-secret",
      data.azurerm_key_vault_secret.client_secret.value
    ]
  }
}

provider "helm" {
  kubernetes {
    host                   = yamldecode(data.azurerm_kubernetes_cluster.kubeconfig.kube_config_raw).clusters[0].cluster.server
    cluster_ca_certificate = base64decode(yamldecode(data.azurerm_kubernetes_cluster.kubeconfig.kube_config_raw).clusters[0].cluster.certificate-authority-data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "/usr/local/bin/kubelogin"
      args = [
        "get-token",
        "--login",
        "spn",
        "--environment",
        "AzurePublicCloud",
        "--tenant-id",
        data.azurerm_key_vault_secret.tenant_id.value,
        "--server-id",
        yamldecode(data.azurerm_kubernetes_cluster.kubeconfig.kube_config_raw).users[0].user.exec.args[4],
        "--client-id",
        data.azurerm_key_vault_secret.client_id.value,
        "--client-secret",
        data.azurerm_key_vault_secret.client_secret.value
      ]
    }
  }
}

# Get kubeconfig from AKS clusters
data "azurerm_kubernetes_cluster" "kubeconfig" {
  name                = local.remote.aks_clusters[var.aks_clusters.lz_key][var.aks_clusters.key].cluster_name
  resource_group_name = local.remote.aks_clusters[var.aks_clusters.lz_key][var.aks_clusters.key].resource_group_name
}

data "azurerm_key_vault_secret" "client_secret" {
  key_vault_id = try(var.keyvaults.keyvaylt_id, local.remote.keyvaults[var.keyvaults.lz_key][var.keyvaults.key].id)
  name         = try(var.keyvaults.client_secret_name, "${local.kubelogin_cred.secret_prefix}-client-secret")
}
data "azurerm_key_vault_secret" "tenant_id" {
  key_vault_id = try(var.keyvaults.keyvaylt_id, local.remote.keyvaults[var.keyvaults.lz_key][var.keyvaults.key].id)
  name         = try(var.keyvaults.tenant_id, "${local.kubelogin_cred.secret_prefix}-tenant-id")
}
data "azurerm_key_vault_secret" "client_id" {
  key_vault_id = try(var.keyvaults.keyvaylt_id, local.remote.keyvaults[var.keyvaults.lz_key][var.keyvaults.key].id)
  name         = try(var.keyvaults.client_id, "${local.kubelogin_cred.secret_prefix}-client-id")
}
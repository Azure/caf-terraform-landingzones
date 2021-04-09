terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.43"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 1.13.2"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 1.3.0"
    }
  }
  required_version = ">= 0.13"
}


provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}


provider "kubernetes" {
  load_config_file       = false
  host                   = try(local.k8sconfigs[0].host, null)
  username               = try(local.k8sconfigs[0].username, null)
  password               = try(local.k8sconfigs[0].password, null)
  client_certificate     = try(local.k8sconfigs[0].client_certificate, null)
  client_key             = try(local.k8sconfigs[0].client_key, null)
  cluster_ca_certificate = try(local.k8sconfigs[0].cluster_ca_certificate, null)
  alias                  = "k8s1"
}

provider "helm" {
  kubernetes {
    load_config_file       = false
    host                   = try(local.k8sconfigs[0].host, null)
    username               = try(local.k8sconfigs[0].username, null)
    password               = try(local.k8sconfigs[0].password, null)
    client_certificate     = try(local.k8sconfigs[0].client_certificate, null)
    client_key             = try(local.k8sconfigs[0].client_key, null)
    cluster_ca_certificate = try(local.k8sconfigs[0].cluster_ca_certificate, null)
  }
  alias = "helm1"
}

provider "kubernetes" {
  load_config_file       = false
  host                   = try(local.k8sconfigs[1].host, null)
  username               = try(local.k8sconfigs[1].username, null)
  password               = try(local.k8sconfigs[1].password, null)
  client_certificate     = try(local.k8sconfigs[1].client_certificate, null)
  client_key             = try(local.k8sconfigs[1].client_key, null)
  cluster_ca_certificate = try(local.k8sconfigs[1].cluster_ca_certificate, null)
  alias                  = "k8s2"
}

provider "helm" {
  kubernetes {
    load_config_file       = false
    host                   = try(local.k8sconfigs[1].host, null)
    username               = try(local.k8sconfigs[1].username, null)
    password               = try(local.k8sconfigs[1].password, null)
    client_certificate     = try(local.k8sconfigs[1].client_certificate, null)
    client_key             = try(local.k8sconfigs[1].client_key, null)
    cluster_ca_certificate = try(local.k8sconfigs[1].cluster_ca_certificate, null)
  }
  alias = "helm2"
}
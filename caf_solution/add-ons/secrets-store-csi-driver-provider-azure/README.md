# Overview

This module provides a method to configure and apply a `SecretProviderClass` object, which is
required to use the `secrets-store-csi-driver-provider-azure` AKS addon.

Note, similar to the `aad-pod-identity` module (`caf_solution/add-ons/aad-pod-identity`), this
module does not install the addon itself. This can be accomplished in a number of ways, including
manually, via Flux, or using helm via `caf_solution/add-ons/aks_applications`.

# Prerequisites

* An AKS cluster
* The `aad-pod-identity` addon
* The `secrets-store-csi-driver-provider-azure` addon

# Usage

```
aks_cluster_key = "cluster_re1"

aks_clusters = {
  cluster_re1 = {
    lz_key = "aks"
    key    = "cluster_re1"
  }
}

csi_keyvault_provider = {
  namespace                = "kube-system"
  create                   = false
  secretproviderclass_name = "azure-tls"
  secret_name              = "azure-tls"
  cert_name                = "wildcard-ingress"
  keyvault_name            = "kv-app-gateway-certs"    # Keyvault name - takes precedence over keyvault_key
  lz_key                   = "lz_key"                  # If keyvault_key is stored in a remote landingzone
  keyvault_key             = "kv_key"                  # The keyvault object key
}
```

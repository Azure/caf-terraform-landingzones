# Azure Kubernetes Service Add-on

The add-on helps you bootstrap AKS cluster with additional components and access control management. Add-on makes use exec plugin authentication ideal for clusters secured by disabling local authentication.

## Features

- Kubernetes RBAC for Azure identities
- Azure role assignment for user identity created by AKS
- helm chart deployment
- manifest deployment via kubernetes provider for configuration handling, CRD Deployment etc

## Pre-Requisites

- The Implementation assumes, you have a service principal created and is part of AKS Admin group (provided in AKS cluster creation configuration)
- The user running deployment (or the impersonating sp) has to access to read this keyvault and fetch service principal mentioned above.


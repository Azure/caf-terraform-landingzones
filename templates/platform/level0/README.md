## Introduction
This directory contains details around the configurations which are deployed to the resources. All the components are deployed in a layered approach.

### Level 0
Deployment Elements  | Resources Deployed
---------------------| ------------------
bootstrap            | This steps bootstrap the environment with gitops prod subscription, deploys caf subscription, and create service principals.
launchpad            | This step deploys launchpad store terraform states and manage deployments.

### Level 1

Deployment Elements           | Resources Deployed
----------------------------- | ------------------
Platform- Subscriptions       | Deploys platform subscriptions such as management, conncetivity, and identity
management                    | Foundation resources to management subscription such as service health alerts, log analytics
gitops                        | This directory hosts the Azure DevOps configurations such as Azure DevOps projects, pipelines variable groups
Identity                      | This hosts the identities for the pipelines and identies are pushed to vault after created
Azure Landing zone - Platform | Deploys Azure landing zone resources such as management groups, custom roles, policies, and map that to management groups


### Level 2

Deployment Elements                 | Resources Deployed
------------------------------------| ------------------
Connectivity - Platform             | Deploys platform connectivity resources Resource Groups, Firewalls, app gateways, Vnet, Public IPs
Connectivity - hub_connection       | Deploys virtual hub connections for the virtual networks
gitops                              | Deploys Azure DevOps agents, aks configurations, identity etc.


# Deployment steps
Below are the steps to be followed for deployment.

## Login the Azure AD Tenant

```bash
az account clear
rover login -t <tenant_name>

```

## Prerequisites



You need a developer machine configured with the dependencies.

| Repo                                                                                              | Description                                                |
|---------------------------------------------------------------------------------------------------|------------------------------------------------------------|
| [Azure Windows 10](../../../documentation/maintainer/set_azure_devops_vm.md) | Azure Windows 10 Virtual Desktop with docker engine, wsl2 and vscode     |

```

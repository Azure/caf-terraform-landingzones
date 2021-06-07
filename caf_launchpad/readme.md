# Cloud Adoption Framework for Azure - Landing zones on Terraform - Launchpad

The launchpad allows you to manage the foundations of landing zone environments by:

* Securing remote Terraform state storage for multiple subscriptions.
* Managing the transition from manual to automated environments.
* Bring up the DevOps foundations using Azure DevOps, Terraform Cloud and GitHub actions (more to come).

Launchpad operates at **level 0**.

For a review of the hierarchy approach of Cloud Adoption Framework for Azure landing zones on Terraform, you can refer to [the following documentation](../../documentation/code_architecture/hierarchy.md).

</BR>

## Getting started with launchpad

Depending on what you are trying to achieve, we provide you with different levels of launchpads to cover different scenario:

| level                 | scenario                                                                                                         | supported environments                     |
|-----------------------|------------------------------------------------------------------------------------------------------------------|--------------------------------------------|
| [100](./scenario/100) | Start with this one! basic functionalities and features, no RBAC or security hardening - for demo and simple POC | working on AIRS subscriptions              |
| [200](./scenario/200) | intermediate functionalities includes diagnostics features                                                       | may not work in AIRS, need AAD permissions |

You can pick your scenario and use one of the following commands:

```bash
# Simple scenario for learning and demonstration
rover -lz /tf/caf/caf_launchpad \
    -launchpad \
    -var-folder /tf/caf/caf_launchpad/scenario/100 \
    -parallelism=30 \
    -a apply

# Advanced scenario - Requires Azure AD privileges
rover -lz /tf/caf/caf_launchpad \
    -launchpad \
    -var-folder /tf/caf/caf_launchpad/scenario/200 \
    -parallelism=30 \
    -a apply

# If the tfstates are stored in a different subscription you need to execute the following command
rover -lz /tf/caf/caf_launchpad \
    -tfstate_subscription_id <ID of the subscription> \
    -launchpad \
    -var-folder /tf/caf/caf_launchpad/scenario/200 \
    -parallelism=30 \
    -a apply
```

</BR>

## Overview of launchpad initialization

![Launchpad Worklow](./documentation/img/launchpad_workflow.png)

The rover executed in launchpad mode performs the following option to bootstrap your environment:

1. **Initialize a terraform state**:
    * The launchpad tries to retrieve an existing terraform state on Azure using the name of the tfstate file and the name of the workspace (level0 by default)
    * Creates a tfstates folder if no remote state have been retrieved, this happens when your environment does not contain a storage account containing a tfstate matching the input parameters

    The Launchpad deployment relies on the following providers:

    * hashicorp/azurerm
    * hashicorp/azuread
    * hashicorp/random
    * aztfmod/azurecaf
    * hashicorp/null

    The latest version of the Launchpad relies on the new capabilities of **Terraform 0.13**

2. **Call Terraform init**:

    * The launchpad then call terraform init to retrieve the provides and modules associated with the deployment

3. **Call terraform apply**:
    * deploy the resources as specified in the launchpad configuration files (see description below)

```bash
Outputs:

aad_apps = <sensitive>
azure_subscriptions = <sensitive>
diagnostics_map = <sensitive>
github_token_keyvault = <sensitive>
global_settings = <sensitive>
keyvaults = <sensitive>
log_analytics = <sensitive>
networking = <sensitive>
resource_groups = <sensitive>
```

4. **Create a workspace to host the local tfsate** - the launchpad will create two containers in the newly created storage account (in step 3):
    * "sandpit" workspace
    * "level0" (by default) workspace

5. **Upload the launchpad state (tfstate) to the storage level0 workspace** - the state contains the default settings, keyvault id, and service principal id created during the launchpad deployment

```bash
Moving launchpad to the cloud
 - storage_account_name: storageaccname
 - resource_group: hrjx-rg-launchpad-tfstates-rVb7GtKPXxHMa
 - storage_key: retrieved
{
  "etag": "\"0x8D833A974C32C5F\"",
  "lastModified": "2020-07-29T10:23:37+00:00"
}
```

</BR>

## Launchpad architecture

Each resource deployed with the launchpad is leveraging the [azurecaf provider](https://github.com/aztfmod/terraform-provider-azurecaf) to enforce naming convention.

The launchpad deploys the following Azure components:

1. Resource groups - By default the launchpad light auto variables will create three resources groups : launchpad-tfstates to host a the tfstate storage account, launchpad-security to host a keyvault, launchpad-devops-agents to host deployment agents should you choose to deploy VMs to automate subsequent deployment using Azure DevOps or GitHub

2. Storage Accounts - a storage account in the launchpad-tfstates reosource group. The storage account contains the tfstate of the launchpad deployment and will be automatically configured as the Terraform remote backend when deploying landing zones with the rover

3. KeyVaults - a keyvault resource to store with Get,List,Set,Delete access to for the logged in user (using the Azure CLI) - the keyvault will contain secrets of service principal accounts and managed identities

4. A Log Analytics workspace and a KeyVault analytics solution deployed in the launchpad-devops-agent resource group. The Log Analytics workspace will gather the monitoring information and logs of both the DevOps agents and of the Keyvault

5. Diagnostic settings - Creates Storage Account and Event Hubs (optional) to be used for diagnostics and operations logs. The resources are created in the launchpad-devops-agent resource group

6. Virtual Network: The Launchpad can create Virtual Networks and subnets to deploy additional workloads during the bootstrap process - typically CI/CD agents

7. Azure Active Directory Applications and role assignment

    This a critical aspect of the launchpad bootstrap process. The deployment creates an Azure AD Application named "caf_launchpad_level0" by default. The launchpad can be configured to create additional Azure AD Applications

    * The user deploying the launchpad is set to be the application owner
    * A Service Principal + random password is created for each Application - the data is then stored in the referenced keyvault as multiple secrets
    * Resource Access is assigned based on the aad_api_permissions object
    * Each application can be assigned one or multiple Azure AD roles through the aad_roles object - empty by default

    By default the underlying service principal will be granted **owner** access to the subscription targeted by the launchpad deployment. This Azure AD Application + Service Principal will be used in subsequent deployments using the Rover.

    API permissions and admin consent are also granted during the bootstrap process. The grant_consent.sh scripts is called for to enable API access for a given Application
    * The variable `aad_api_permissions` object can contains multiple entries
    * each key references one of the Application defined in the `aad_apps` variable. The content of each entry is an api permission definition.

    The objectId, ApplicationId, ServicePrincipalID, client_secret are each stored in a keyvault using the secret_prefix value as defined in the code example

    The example below shows an App Definition, a role assignment and an API permission assignment. using three terraform variables with define an app called "caf_launchpad_github_terraformdev_github-integration-landingzones", we assign the Application Developer role to this application, finally we grand admin consent to the Active Directory Graph APIs.

    ```terraform
    aad_apps = {
        azure_caf-terraform-landingzones = {
            application_name        = "caf_launchpad_github_terraformdev_github-integration-landingzones"
            password_expire_in_days = 60
            tenant_name             = "terraformdev.onmicrosoft.com"
            keyvault  = {
                keyvault_key          = "launchpad"
                secret_prefix         = "caf-launchpad-github-terraformdev-github-integration-landingzones"
            }
        }
    }
    aad_roles = {
        azure_caf-terraform-landingzones = {
            roles = [
                "Application Developer"
            ]
        }
    }

    aad_api_permissions = {
        azure_caf-terraform-landingzones = {
            active_directory_graph = {
            resource_app_id = "00000002-0000-0000-c000-000000000000"
            resource_access = {
                active_directory_graph_resource_access_id_Application_ReadWrite_OwnedBy = {
                id      = "824c81eb-e3f8-4ee6-8f6d-de7f50d565b7"
                type    = "Role"
                }
                active_directory_graph_resource_access_id_Directory_ReadWrite_All = {
                id      = "78c8a3c8-a07e-4b9e-af1b-b5ccab50a175"
                type    = "Role"
                }
            }
            }
        }
    }
    ```

    The Azure Active Directory Application creation, Role assignment and Admin Consent delegation plays a critical role in the launchpad bootstrapping process. Make sure to work with your Tenant administrators to define the scope and the roles assigned the Application created by the launchpad.

8. Release Agents (Optional):
    * Deploys Virtual machines in the targeted Virtual Network. You may choose to leverage an existing Azure DevOps organization and deploy CI/CD agents and pipelines. The Agents will then be in charge of subsequent rover deployments to automate the IaC provisioning with Terraform

## Launchpad add-ons

Add-ons are additional capabilities to enhance the launchpad, that are deployed separately and managed by a different state.

Current add-ons:

* Azure DevOps Self Hosted Agents and Pipeline

In-development add-ons:

* Terrform Cloud Enterprise
* GitHub Actions

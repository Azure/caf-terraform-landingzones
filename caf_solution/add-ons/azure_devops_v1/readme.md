# Cloud Adoption Framework for Azure - Landing zones on Terraform - Azure Devops add-on

The Azure Devops add-ons allow you to setup you Azure Devops environment as a platform to automate all your subsequent landing zone deployment from level 0 until level 4 through Azure pipelines with self hosted agents.

* Azure Devops:
  - Projects
  - Agent Pools (Organization and Project Level)
  - Service Endpoints
  - Variables and Variable Groups
  - Pipelines

Azure Devops add-on landing zone operates at **level 0**

For a review of the hierarchy approach of Cloud Adoption Framework for Azure landing zones on Terraform, you can refer to [the following documentation](../../documentation/code_architecture/hierarchy.md).

## Dependencies

Landing zone:
* CAF Launchpad (Scenario 200 or above)

Azure Devops (example):
* Organization: https://dev.azure.com/azure-terraform
* Project     : contoso_demo (https://dev.azure.com/azure-terraform/contoso_demo)
* Repo        : caf-configuration (https://dev.azure.com/azure-terraform/contoso_demo/_git/caf-configuration)
  - In order for pipeline to work properly, YAML file should be in this repo and referred accordingly under pipeline section in azure_devops.tfvars
  - sample yaml attached [here](./scenario/200-contoso_demo/pipeline/rover.yaml).

Azure:
* AZDO PAT Token   : PAT Token should be updated in keyvault secret that deployed by launchpad LZ as below
* Github PAT Token : If building from repos hosted in Github, a Github PAT Token should be added to a keyvault secret.


## Pipelines
AZDO supports creating pipelines from a number of sources, such as AZDO itself, Github, Bitbucket,
etc. For repos hosted in Github, you must configure a [service connection][https://docs.microsoft.com/en-us/azure/devops/pipelines/library/service-endpoints].

To do this, create a Github PAT token (repo read access is sufficient), and add it to a KeyVault (we
recommend the 'secrets' KeyVault typically provisioned in level0). Then provide the following config
directive to configure the connection:

```
service_endpoints = {
  github_endpoint = {
    endpoint_name = "github_endpoint"
    type = "Github"
    project_key = "my_project""
    keyvault = {
      lz_key      = "launchpad"
      key         = "secrets"
      secret_name = "github-pat"
    }
  }
}
```

When configuring pipelines via the pipelines{} config directive, you can then set the following
parameters:

```
pipelines = {
  launchpad = {
    project_key      = "my_project"
    repo_project_key = "my_project_repo"
    name             = "launchpad"
    folder           = "\\configuration\\level0"
    yaml             = "configuration/dev/pipelines/test.yml"
    repo_type        = "GitHub"
    git_repo_name    = "github_org/repo_name"
    branch_name      = "main"
    service_connection_key = "github_endpoint"
    variables = {
      ...
    }
  }
}
```


![](./documentation/images/pat_token.png)

## Deployment

```bash
rover -lz /tf/caf/caf_solution/add-ons/azure_devops_v1 \
  -tfstate azure_devops-contoso_demo.tfstate \
  -var-folder /tf/caf/caf_solution/add-ons/azure_devops_v1/scenario/200-contoso_demo \
  -parallelism 30 \
  -level level0 \
  -env sandpit \
  -a apply


# If the tfstates are stored in a different subscription you need to execute the following command
rover -lz /tf/caf/caf_solution/add-ons/azure_devops_v1 \
  -tfstate_subscription_id <ID of the subscription> \
  -tfstate azure_devops-contoso_demo.tfstate \
  -var-folder /tf/caf/caf_solution/add-ons/azure_devops_v1/scenario/200-contoso_demo \
  -parallelism 30 \
  -level level0 \
  -env sandpit \
  -a apply
```

We are planning to release more examples on how to deploy the Azure Devops Agents.

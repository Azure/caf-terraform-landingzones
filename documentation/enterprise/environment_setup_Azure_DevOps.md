# Enterprise Adoption Guide on Cloud Adoption Framework for Azure - Landing zones on Terraform 

## Overview

Enterprise deployment is complex. We propose an approach that uses automation to reproduce this complexity (the subscriptions and the Azure Active Directory) and to test and validate patterns multiple times before hitting a production environment. Using standardized deployments and battlefield-proven artefacts ensures reliability.

## Azure Sandpit Environment

Successful implementations tend to focus on first building a sandpit / innovation hub environment where all stakeholders (IT operations, security, compliance, information protection, finance, and business) define their requirements. The DevOps team builds, automates, tests modules, blueprints, and landing zones to create an infrastructure environment that is good enough.

We define a sandpit environment as an environment where innovation and experimentations can happen freely. As such is it composed of:
-	One or more subscriptions that are isolated from ANY customer environment.
-	A separate Azure AD tenant space.

## Azure DevOps

### Organization

### Projects

Ideally multiple projects needed to fully utilize Azure LZ capabilities:

* Main Project - Repo of your private terraform code and project management for LZ adoption in your organization
* Configuration Projects - For each environments (Prod, NonProd, Sandpit) that you plan to leverage Azure Terraform Landing Zone, dedicated project in Azure Devops is needed to fully utilize the automation mechanism that the LZ provided. 

Examples Azure DevOps setup:

| Organization | Project | Purpose |
| ------------ | ------- | ------- |
| Contoso | Azure Terraform Landing Zone | Project Management of LZ and Repository for custom terraform code that specific to Contoso requirements |
| Contoso | Landing Zone Sandpit         | Repo to Store configuration file (tfvars), Pipeline, agent pool specific to sandpit                    |
| Contoso | Landing Zone Non Production  | Repo to Store configuration file (tfvars), Pipeline, agent pool specific to nonprod                    |
| Contoso | Landing Zone Production      | Repo to Store configuration file (tfvars), Pipeline, agent pool specific to prod                       |


### Repositories

During the lifecycle of the landing zones deployment you will probably find that it is easier to work first with a mono-repository environment (mixing Terraform code and variables) especially when you focusing on sandpit deployment until you have good enough state to move to other environment. Azure Devops Main project would be a good one to start with and slowly transition your config related code to environment specific project. 

From an Azure DevOps perspective, you will use multi repo pipelines and check-out. The repos can also be located cross-projects within the same organization. 

## Bootstrap process

### Bootstrap Identity
In order to start consuming Azure Terraform LZ we need to have account with specific privileges to boostrap your environment. You can choose between:
1. Using User account with enough permission commonly Global Admin
2. Provision the identity bootstrap account with Azure AD application, you can refer to [the following documentation](./bootstrap_account_provisioning.md)


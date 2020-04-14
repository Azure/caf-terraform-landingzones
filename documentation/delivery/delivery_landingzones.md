# Delivery model for landing zones

Cloud Adoption Framework for Azure landing zones for Terraform are to be delivered mainly by DevOps, this includes providing guidances and toolset for deploying and operating an environment.

## DevOps components

For DevOps and innovation to happen, we will have the following components to enforce configuration and applications inside Microsoft Azure:

- **A inner feedback loop**:
Meant to provide very quick feedback to developers and DevOps engineers, offers the possibility to develop code, test it fast and iterate at fast pace.
- **DevOps pipelines enforcing the landing zones**:
A whole execution environment composed of pipelines executed in a customer environment.

![PipelinesOverview](../../_pictures/delivery/overview_pipelines.png)

- **Rover** is the DevOps toolchain that enables deployments as described [here](../code_architecture/intro_architecture.md).

- **Terraform scripts repositories**:  will be used to store and describe logic of Terraform deployments (the script and core code that will be executed)

- **Terraform configuration repositories**: will be used to store and describe the configuration of the environment and of the applications.
Different environments like PROD, DEV, UAT, etc. will be implemented using different configuration files inside the configuration repository.

The Azure pipelines will be using Azure DevOps hosted agents will be authenticated by Azure Active Directory using Managed Identities. In order to control privileges and reduce attack surface, we propose a hierarchy of pipelines that is described [here](../code_architecture/hierarchy.md).

## Repositories topology

During the lifecycle of the landing zones deployment you will find that it is easier to work with mono-repository environment (mixing Terraform and code variable). This is absolutely fine and will mature  over time, as you add more modules, more complex environments and you want to move towards a full cycle of release.

Multiple approaches are valid depending on the size of your organization:

- By environment types:

```bash
tfvars
├── uat
|   uat_landingzone_caf_foundations.tfvars
|   uat_landingzone_networking.tfvars
├── prod
├── sandpit
├── ...
```

- By "classic" team structures
``` bash
tfvars
├── networking
|   uat_landingzone_networking.tfvars
|   test_landingzone_networking.tfvars
|   prod_landingzone_networking.tfvars
├── audit
├── governance
├── etc.
```

## GitOps for Azure landing zones

Changes in the different environments introduced and promoted following GitOps concepts, principles and mechanisms:

- Configuration changes are described in a declarative language (here using Terraform).
- Operations are promoted from one environment to another via Git operations (Git commit, push, pull request).
- Changes are promoted only once they have reached quality gates (provided by automation, CI mechanisms and test suites executions) to promote higher quality changes.
- Changes are promoted only once they also have been validated by service owners in the environment (that can be declared in the DevOps configuration of the platform).

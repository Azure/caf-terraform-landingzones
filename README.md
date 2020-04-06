[![Gitter](https://badges.gitter.im/aztfmod/community.svg)](https://gitter.im/aztfmod/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

# Introduction to Azure Cloud Adoption Framework landing zones for Terraform

Microsoft Cloud Adoption Framework for Azure provides you with guidance to adopt Azure. When deploying resources in a new environment, you can leverage landing zones and blueprints to accelerate your deployment. A landing zone is a set of infrastructure components that assembled together will deploy a complete environment ready to host an application.

For full details on Cloud Adoption Framework, refer to http://aka.ms/caf. For any idea, bug, please fill in an issue. You can also reach out to us on tf-landingzones at microsoft dot com.

## Overview

A landing zone is a fully ready environment to host your application in the cloud. The set of CAF landing zones are aligned with Cloud Adoption Framework recommendations, and allow you to quickly scaffold a deployment with fundamentals of cloud management.

Examples of landing zones:

- Hub and spoke topology
- Lambda architecture with Databricks
- Mobile application development platform
- Citrix cloud
- SAP BusinessOne

### Available landing zones

Currently we provide you with the following landing zones:

| Name | Purpose | Depends on | Tested with launchpad
| ------- | ---------------- | -- | -- |
| [landingzone_caf_foundations](./landingzones/landingzone_caf_foundations)  | setup all the fundamentals for a subscription (logging, accounting, security.). You can find all details of the caf_foundations landing zone [Here](./landingzones/landingzone_caf_foundations/readme.md) | N/A | launchpad_opensource_light |
| [landingzone_hub_spoke](./landingzones/landingzone_hub_spoke) | example of [hub and spoke environment](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/hybrid-networking/hub-spoke) documentation [here](./landingzones/landingzone_hub_spoke/readme.md) | landingzone_caf_foundations | launchpad_opensource_light |
| [landingzone_vdc_demo](./landingzones/landingzone_vdc_demo)  | setup a demo environment of a hub-spoke topology including shared services, as well as various DMZ (ingress, egress, transit). You can find all details of the vdc_demo landing zone [Here](./landingzones/landingzone_vdc_demo/readme.md)| landingzone_caf_foundations | launchpad_opensource_light |
| [landingzone_secure_vnet_dmz](./landingzones/landingzone_secure_vnet_dmz)  | (preview) this is an early implementation of the reference architecture [secure_vnet_dmz](https://docs.microsoft.com/en-gb/azure/architecture/reference-architectures/dmz/secure-vnet-dmz). This is a work in progress used to illustrate landing zone creation process as described [here](./documentation/code_architecture/how_to_code_a_landingzone.md) . You can find all details of the secure vnet dmz landing zone [Here](./landingzones/landingzone_secure_vnet_dmz/readme.md)| landingzone_caf_foundations | launchpad_opensource_light |
| [landingzone_starter](./landingzones/landingzone_starter)  | this is an empty landing zones to use as a template to develop a level 2 landing zone. You can find all details of the starter landing zone [Here](./landingzones/landingzone_starter/readme.md)| landingzone_caf_foundations | launchpad_opensource_light |

## Getting started

We recommend developing and deploying landing zones using Visual Studio Code, leveraging VS Code Development Containers allows a smooth transition from your dev machine to your the execution environnement (the rover).

### Prerequisites

In order to start deploying your with CAF landing zones, you need the following components installed in your environment:

- [Visual Studio Code](https://code.visualstudio.com/)
- [Docker](https://docs.docker.com/docker-for-windows/install/)
- [Git](https://git-scm.com/downloads)

You can deploy it easily on Windows and MacOS with the following software managers:

MacOS | Windows |  
------- | ----------------
```brew cask install visual-studio-code docker``` </br> ```brew install git ``` | Install Chocolatey (https://chocolatey.org/docs/installation) </br> ``` choco install git vscode docker-desktop ```

Once installed, open **Visual Studio Code** and install "**Remote Development**" extension as follow: ![RemoteDevelopment](./_pictures/caf_setup_remotedev.png)

### Cloning the repository

Cloning your first repository:

```bash
git clone https://github.com/Azure/caf-terraform-landingzones.git
```

### Open the repository in Visual Studio Code

Open the repository you've just cloned in Visual Studio Code, click on the lower bar, green sign and in the palette opening on the top of Visual Studio Code Window, select **"Open Workspace in container"**

![RemoteDevelopment](./_pictures/caf_remote_dev.png)

This should take a while, in the meantime, feel free to click on Details to see the container being downloaded from the registry and being connected to yur local environment:

![SetupContainer](./_pictures/caf_setup_container.png)

You will have to accept local mapping to your filesystem when Docker prompts you (here's [how you reconfigure Docker Desktop to allow fileshares](./_pictures/caf_setup_docker_fileshares.png) ), so that you can access your files from your container.

![Ready](./_pictures/caf_dev_ready.png)

After a while, your environment is ready, note on the lower left part of Visual Studio Code, that you are now in your Azure CAF rover, which is your environment to use Azure landing zones.

### Deploying your first landing zone

You must be authenticated first:
For that we will rely on Azure authentication as completed by Azure Cli, via browser method:

```bash
rover login
```

We recommend that you verify the output of the login and make sure the subscription selected by default is the one you want to work on. If not, you can use the following switch: 

```bash
az account set --subscription <subscription_GUID>
```

On the first run, you need to use the launchpad to create the foundations for Terraform environment, the launchpad_opensource is the current way to set those foundations.

Running the following command: 

```bash
launchpad /tf/launchpads/launchpad_opensource_light apply
```

This command will interactively prompt you for *var.location*, asking for the name of a supported Azure region **where you want to deploy the Terraform state and dependencies**. You can specify that in the argument as in the following example:  

```bash
launchpad /tf/launchpads/launchpad_opensource_light apply -var 'location=westus'
```

You can then launch your first landing zone!

Please note that each landing zone come with its own deployment settings, which may deploy resources in different region than where you set the foundations.  

You are ready to start:

```bash
rover /tf/caf/landingzones/landingzone_caf_foundations plan
```

```bash
rover /tf/caf/landingzones/landingzone_caf_foundations apply
```

```bash
rover /tf/caf/landingzones/landingzone_caf_foundations destroy
```

## Updating your development environment

If you are using previous version of Azure landing zones (v1.0.1912), since we migrated to use new version of the rover, which uses non-root containers, you will have to re-create your volumes.
You can achieve that running the following commands:

```bash
# To list all Dev Container volumes
docker volume ls -f label=caf

# To cleanup de Dev Container volumes make sure there is not running or stopped containers
docker ps
docker ps -a

# To cleanup a specific Dev Container
docker volume rm -f $(docker volume ls -f label=com.docker.compose.project=landingzones_devcontainer)

# To cleanup all Dev Containers
docker volume rm -f $(docker volume ls -f label=caf)
```

You can also purge Docker cache running the following command:

```bash
docker system prune -a
```

Happy deployment with Azure landing zones, let us know your feedback and how you need it to evolve!

## Documentation

More details on how to develop, deploy and operate with landing zones can be found in the reference section [here](./documentation/README.md)


## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

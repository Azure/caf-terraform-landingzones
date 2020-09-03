# landingzone networking 

This landing zone allows you to compose the current Azure networking topologies as:
- Azure Virtual networks with Network Security Groups (NSG), Azure Bastion, Azure Firewall, etc. 
- Hub and spoke using Virtual Networks 
- Hub and spoke with Azure Virtual WAN

## Prerequisites

This landing zones assumes that you already have deployed:
- launchpad (level 0)
- landingzone_caf_foundations (level 1)

## Deploying this landing zone

```bash
rover -lz /tf/caf/landingzones/landingzone_networking -a plan -var-file /tf/caf/landingzones/landingzone_networking/examples/103-hub-vnet-with-firewall/configuration.tfvars
```
Review the configuration and if you are ok with it, deploy it by running:
```bash
rover -lz /tf/caf/landingzones/landingzone_networking -a apply -var-file /tf/caf/landingzones/landingzone_networking/examples/103-hub-vnet-with-firewall/configuration.tfvars
```
Have fun playing with the landing zone an once you are done, you can simply delete the deployment using:
```bash
rover -lz /tf/caf/landingzones/landingzone_networking -a destroy -var-file /tf/caf/landingzones/landingzone_networking/examples/103-hub-vnet-with-firewall/configuration.tfvars
```

More details about this landing zone can also be found in the landing zone folder and its blueprints subfolders.

## Contribute

Pull requests are welcome to evolve the framework and integrate new features.




Please refer to the ```/examples``` sections to see ways to leverage it to achieve various networking scenarios.

<!--- BEGIN_TF_DOCS --->
<!--- END_TF_DOCS --->
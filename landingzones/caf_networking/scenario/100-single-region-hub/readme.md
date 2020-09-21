# Multi-region hub with global peering

This scenrio deploys the networking hub across multiple regions

Region1 and Region2:
* One virtual network with multiple subnets
* Peerting to Launchpad release vnet and the vnet in the other region
* Subnets for virtual gateway, firewall, bastion host, jumpbox, private links
* Empty NSGs on each subnet
* Bastion host to access the jumpbox server


## Dependencies
Landing zones:
* CAF Foundations
* CAF Launchpad

##  Deployment

```bash
# Deployment command
rover -lz /tf/caf/landingzones/caf_networking/ -var-file /tf/caf/landingzones/caf_networking/scenario/200-single-region-hub/configuration.tfvars -tfstate networking_hub.tfstate -a apply

# Destroy command
rover -lz /tf/caf/landingzones/caf_networking/ -var-file /tf/caf/landingzones/caf_networking/scenario/200-single-region-hub/configuration.tfvars -tfstate networking_hub.tfstate -a destroy
```
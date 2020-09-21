
# Review the configuration file

* Adjust the default location
* Define the regions where the services are deployed
* Deploy a diagnostics logging storage account on those locations

## Deploy the launchpad light

```bash
cd /tf/caf

#  to deploy the launchpad
rover -lz /tf/caf/landingzones/caf_launchpad -launchpad -var-file /tf/caf/landingzones/caf_launchpad/scenario/101-opensource-light/configuration.tfvars -a apply -w tfstate

# to destroy the launchpad landing zone
rover -lz /tf/caf/landingzones/caf_launchpad -launchpad -var-file /tf/caf/landingzones/caf_launchpad/scenario/101-opensource-light/configuration.tfvars-a destroy -w tfstate
```

## Deploy the advanced launchpad

```bash
cd /tf/caf

#  to deploy the launchpad
rover -lz /tf/caf/landingzones/caf_launchpad -launchpad -var-file /tf/caf/landingzones/caf_launchpad/scenario/402-dual-region-essential/configuration.tfvars -parallelism=30 -tfstate launchpad.tfstate -w tfstate -a apply

# to destroy the launchpad landing zone
rover -lz /tf/caf/landingzones/caf_launchpad -launchpad -var-file /tf/caf/landingzones/caf_launchpad/scenario/402-dual-region-essential/configuration.tfvars -parallelism=30 -tfstate launchpad.tfstate -w tfstate -a destroy
```

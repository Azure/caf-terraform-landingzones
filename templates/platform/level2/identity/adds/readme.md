
### Identity - Active Directory Domain Controllers (ADDS)

Deploy 2 domain controllers in the primary region

```bash
# login a with a user member of the caf-maintainers group
rover login -t {{ config.tenant_name }}

cd {{ config.configuration_folders.destination_base_path }}landingzones
git fetch origin
git checkout {{ config.caf_landingzone_branch }}

export ARM_USE_AZUREAD=true
caf_env="{{ config.caf_terraform.launchpad.caf_environment }}"

rover \
  -lz {{ config.configuration_folders.destination_base_path }}landingzones/caf_solution \
  -var-folder {{ config.configuration_folders.destination_base_path }}{{ config.configuration_folders.destination_relative_path }}/{{ level }}/{{ tfstates["identity_adds"].base_config_path }}/adds \
  -tfstate {{ tfstates["identity_adds"].tfstate }} \
  -log-severity ERROR \
  -env ${caf_env} \
  -level {{ level }} \
  -a plan

```

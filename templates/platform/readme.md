
# Generate the terraform configuration files

## Deploy into a multi subscription

```
org_name=<orgname>

rover -bootstrap \
  -aad-app-name ${org_name}-platform-landing-zones \
  -gitops-service github \
  -gitops-number-runners 2 \
  -bootstrap-script '/tf/caf/landingzones/templates/platform/deploy_platform.sh ' \
  -playbook '/tf/caf/landingzones/templates/platform/caf_platform_prod_nonprod.yaml' \
  -subscription-deployment-mode multi_subscriptions \
  -sub-management <sub_id_management> \
  -sub-connectivity <sub_id_connectivity> \
  -sub-identity <sub_id_identity> \
  -sub-security <sub_id_security>

```
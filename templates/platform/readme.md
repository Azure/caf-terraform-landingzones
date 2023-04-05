
# Generate the terraform configuration files

## Deploy into a multi subscription

```
org_name=contoso_ind

rover -bootstrap \
  -aad-app-name ${org_name}-platform-landing-zones \
  -gitops-service github \
  -gitops-number-runners 4 \
  -bootstrap-script '/tf/caf/landingzones/templates/platform/deploy_platform.sh ' \
  -playbook '/tf/caf/landingzones/templates/platform/caf_platform_prod_nonprod.yaml' \
  -subscription-deployment-mode multi_subscriptions \
  -sub-management www-guid \
  -sub-connectivity xxx-guid \
  -sub-identity yyy-guid \
  -sub-security zzz-guid

```



# Generate the terraform configuration files

## Deploy into a multi subscription

```
org_name=bsdev

rover -bootstrap \
  -aad-app-name ${org_name}-platform-landing-zones \
  -gitops-service github \
  -gitops-number-runners 4 \
  -bootstrap-script '/tf/caf/landingzones/templates/platform/deploy_platform.sh ' \
  -playbook '/tf/caf/landingzones/templates/platform/caf_platform_prod_nonprod.yaml' \
  -subscription-deployment-mode multi_subscriptions \
  -sub-management bd8d39e7-7c85-49ec-b83c-42f3bc12f528 \
  -sub-connectivity ef3cbe94-c49a-4d70-b934-4e39d252ed76 \
  -sub-identity 7313e4ce-c894-473a-aac2-ad1042721278 \
  -sub-security d7713207-42a5-4912-9e48-0e63acc16550

```

{'region1': 'westeurope', 'region2': 'norwayeast'}
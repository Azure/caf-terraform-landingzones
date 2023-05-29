
```bash

# Create a Teams or personnal token (not an organization token as some feature are not supported with that token)
terraform login

export ARM_SUBSCRIPTION_ID=
export ARM_CLIENT_ID=
export ARM_TENANT_NAME=
export ARM_TENANT_ID=
export ARM_CLIENT_SECRET=

az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET -t $ARM_TENANT_ID
az account set -s $ARM_SUBSCRIPTION_ID

export TF_CLOUD_ORGANIZATION=
export TF_CLOUD_HOSTNAME=
export TF_CLOUD_PROJECT_ID=
export REMOTE_credential_path_json="$(echo ~)/.terraform.d/credentials.tfrc.json"
export BACKEND_type_hybrid=false
export GITOPS_AGENT_POOL_EXECUTION_MODE=remote    # This deployment is using hosted TFC agents
# export GITOPS_AGENT_POOL_NAME=contoso-demo-pool
export TF_VAR_backend_type=remote
export BACKEND_type_hybrid=false

# Set the Azure devops Admin (full access) PAT token
export TF_CLOUD_WORKSPACE_TF_SEC_VAR_azdo_pat_admin=
export TF_CLOUD_WORKSPACE_ATTRIBUTES_ASSESSMENTS_ENABLED=true

rover \
  -lz /tf/caf/landingzones/caf_solution/add-ons/azure_devops_v1 \
  -var-folder /tf/caf/landingzones/caf_solution/add-ons/azure_devops_v1/scenario/300-secure-bootstrap/devops_setup \
  -tfstate_subscription_id $ARM_SUBSCRIPTION_ID \
  -target_subscription $ARM_SUBSCRIPTION_ID \
  -tfstate azdocontoso.tfstate \
  -env contoso \
  -p ${TF_DATA_DIR}/azdocontoso.tfstate.tfplan \
  -tf_cloud_force_run \
  -a plan 

```


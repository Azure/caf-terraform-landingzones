# Unit and integration testing

The module performs surface level testing and integration testing on Azure. The test folder contains the relevant test using Go and the Azure SDK with the Resource Graph API

## Usage

To run this unit test, simply execute:

to run the integration test, first perform a Terraform plan and output the result in json:

```shell
terraform init
terraform plan -no-color -out PATH-TO-PLAN-FILE
terraform show -json PATH-TO-PLAN-FILE > <PATH-TO-PLAN-FILE>.json
export JSON_PLAN_PATH="<PATH-TO-PLAN-FILE>.json"
```

Once you are done, just run the unit tests, you will need go installed in addition to the dependencies:

```shell
cd test/unit
go get -t ./...
go test
```

Next step is to deploy the plan on Azure:

```shell
cd examples/rg_simple
terraform apply -no-color -auto-approve PATH-TO-PLAN-FILE
```

Integration tests are located under the test/integraiton folder

```shell
cd test/integration
go get -t ./...
go test
```

Finally make sure to destroy the resources that you deployed

```shell
cd examples/rg_simple
terraform destroy
```

## Tooling

- **GitHub Actions** for the CI/CD pipeline
- **Golang** for the unit tests
- **Rover** as a docker container to run the tests
- **Azure Resource Graph** as the backbone query language for the integration testing

## Pipeline

![alt text](../../_pictures/test/pipeline.png?raw=true)

Our pipeline is split in multiple steps, performing both unit and integration tests:

- high level syntax validation of the terraform files using terraform validate
- Unit Testing to validate the output of the Plan : terraform plan + terraform show to output the plan as Json + Golang unit testing
- Deployment: Terraform apply reusing the tfplan file from the previous stage
- Integration testing using Golang + the Azure SDK and the Resource Graph API
- Cleanup the resources using terraform destroy

All these steps run in a the rover.

### Configuring the pipeline

To prepare the environment for the multiple stages we need to configure authentication to Azure resources both for Terraform and the Azure SDK by setting Env variables at the beginning of a pipeline. These variables will be available for every job and step in your GitHub Actions.

![alt text](../../_pictures/test/env_pipeline.png?raw=true)

![alt text](../../_pictures/test/secrets.png?raw=true)

## Running the unit tests

The Cloud Adoption Framework with Terraform supports version 0.12 and onwards, which means we can safely use the JSON Output Format introduced with theterraform show -json \<FILE\> command to generate a JSON representation of a plan or state file. See the terraform show documentation for more details.
The unit testing phase consists of the following steps:

1) Retrieve the latest code from the repository
2) Perform a Terraform Init + Terraform Validate
3) Call Terraform Plan and store both the tfplan and the json output in a file
4) Export the json file location to the JSON_PLAN_PATH environment variable
5) Retrieve the go dependencies `go get -t ./...` and run the tests `go test`

### About the unit tests

The core of the Unit testing is performed in Go as it gave more flexibility to leverage a Unit Test Framework and validate the output created by Terraform.
The unmarshalling process to a Go Structure is performed by the lib from Hashicorp  : “github.com/hashicorp/terraform-json”. This Library provides typed object mapping to the structure of the Json object returned by the terraform show -json command.

The UnmarshalJSON methods returns a Plan struct that can easily be compared to the expected values (e.g resource creation, resource name, tags…).

## Deployment to Azure

To perform integration testing you first need to deploy the resources on Azure with `terraform apply`

As an additional testing phase you may compare the TF apply output to the expected result of your IaC architecture

## Integration testing with the Azure Resource Graph + Azure Go SDK

Once the deployment is successful, we want to perform an integration test and validate the resources available on our Azure subscription. Do to so we’re leveraging the Azure Resource Graph API.
*Why the Resource Graph API and not simply an access using the resource’s native APIs*? Simply because the resource graph provides an easy yet powerful and consistent syntax to retrieve each properties of an ARM resource.

Make sure your unit tests include the following dependencies :

- “github.com/Azure/azure-sdk-for-go/services/resourcegraph/mgmt/2019–04–01/resourcegraph” to perform a Resource Graph query
- “github.com/Azure/go-autorest/autorest/azure/auth” to perform authentication against my Azure subscription. A Unit test simply calls the Resource Graph query and validates the output against the expected result.


![alt text](../../_pictures/test/unit_test_sample.png?raw=true)

## Cleanup the environment after the integration test

Make sure to cleanup your environment using `terraform destroy` after performing the unit tests to release any resources created in the previous steps.

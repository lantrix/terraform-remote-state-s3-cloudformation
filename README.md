This is a [Terraform remote state](https://www.terraform.io/docs/language/settings/backends/index.html) using AWS [S3 & DynamoDB](https://www.terraform.io/docs/language/settings/backends/s3.html).

## Deploy

- Deploy the cloudformation stack in your region (e.g. `ap-southeast-2`)
  - Deploy the stack `make deploy`
  - Deploy a managed policy to attach to IAM roles `make deploy-policy`

## Usage

- Initialise your terraform project to reference the state resources

```shell
export accountId=$(aws sts get-caller-identity --query Account --output text)
terraform init \
    -backend-config="region=ap-southeast-2" \
    -backend-config="bucket=terraform-state-${accountId}" \
    -backend-config="key=terraform.tfstate" \
    -backend-config="dynamodb_table=terraform-state"
```

- Ensure you reference the state in the terraform project. You can use the [`workspace_key_prefix`](https://www.terraform.io/language/settings/backends/s3#workspace_key_prefix) to differentiate each project in the state store.

```terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    workspace_key_prefix = "my-project"
  }
}

provider "aws" {
  region = "ap-southeast-2"
}
```

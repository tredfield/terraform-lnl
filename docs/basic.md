# Basic Terraform Project

We will start with a basic terraform project. The below terraform configures an AWS provider and creates an EC2 instance

## main.tf

```hcl
# main.tf

# The terraform {} block contains Terraform settings, including the required 
# providers Terraform will use to provision your infrastructure
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  # This is terraform version required
  required_version = ">= 1.2.0"
}

# Required provider requires a corresponding provider block. There can be
# multiple provider blocks for a given provider. For example to define an AWS
# provider for each region you plan to deploy infrastructure
provider "aws" {
  region = "us-west-2"
}

# Use resource blocks to define components of your infrastructure. This is an 
# example ec2 instance
resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  tags = {
    Name = "TerraformDemo"
  }
}
```

### terraform block

The `terraform {}` block contains Terraform settings, including the required providers Terraform will use to provision your infrastructure.

### AWS Provider

For each provider you must configure a provider block. The provider block allows configuring settings on the provider, for example region. There can be multiple provider blocks for a given provider. For example to define an AWS provider for each region you plan to deploy infrastructure.

### Resources

Resources are what you use to configure infrastructure such as an EC2 instance

## Run terraform init

Running terraform init will initialize the project creating local terraform state files

```bash
terraform init
```

Now I have these files

```bash
.
├── .terraform
├── .terraform.lock.hcl
├── demo.md
└── main.tf
```

## Run terraform fmt and terraform validate

It is a good practice to run terraform format `fmt` and `validate` commands

```bash
terraform fmt -recursive
terraform validate
```

!!! tip

    Good idea to run validate in your CI jobs and fmt as pre-commit hook

## Run terraform plan

Running terraform plan Terraform prints out the execution plan which describes the actions Terraform will take in order to change your infrastructure to match the configuration.

You should always review the plan before applying it

```bash
terraform plan -out plan.out
```

## Run terraform apply

This will apply the plan and create resources

```bash
terraform apply plan.out
```

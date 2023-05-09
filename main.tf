# The terraform {} block contains Terraform settings, including the required providers 
# Terraform will use to provision your infrastructure
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

# Required provider requires a corresponding provider block. There can be multiple
# provider blocks for a given provider. For example to define an AWS provider for each region
# you plan to deploy infrastructure
provider "aws" {
  region = "us-west-2"
}

# Use resource blocks to define components of your infrastructure. This is an example ec2 instance
resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  tags = {
    Name = "TerraformDemo"
  }
}
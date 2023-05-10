# The terraform {} block contains Terraform settings, including the required providers 
# Terraform will use to provision your infrastructure
terraform {
  backend "http" {
  }
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
  key_name      = aws_key_pair.this.key_name

  # This EC2 Instance has a public IP and will be accessible directly from the public Internet
  associate_public_ip_address = true

  # Security groups for ssh
  vpc_security_group_ids = ["${aws_security_group.this.id}"]

  tags = {
    Name = "TerraformDemo"
  }
}

# Creates a private key
resource "tls_private_key" "this" {
  algorithm = "RSA"
}

# Creates an AWS key pair for ec2 instance
resource "aws_key_pair" "this" {
  key_name   = "tf-demo"
  public_key = tls_private_key.this.public_key_openssh
}

# Security group to allow ssh
resource "aws_security_group" "this" {
  name = "sg_tf_demo"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    # To keep this example simple, we allow incoming SSH requests from any IP. In real-world usage, you should only
    # allow SSH requests from trusted servers, such as a bastion host or VPN server.
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# create an S3 bucket
resource "aws_s3_bucket" "example" {
  bucket = "terraform-lnl-test-bucket"

  tags = {
    Name = "TerraformDemo"
  }
}

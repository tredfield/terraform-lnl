# demo.md

## Install Terraform

Recommend using an installer such as brew or choco for windows

```bash
# mac
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

``` bash
# windows
choco install terraform
```

## Local AWS Setup

For running terraform locally you need to provide credentials for most Terraform providers. This typically can be done via environment variables. Here is how to setup AWS

Note I use <https://www.passwordstore.org> below for retriving secrets locally

1. Export AWS credentials

```bash
export AWS_ACCESS_KEY_ID=AKIAQINXMUNZQOZILKJS
export AWS_SECRET_ACCESS_KEY=$(pass /work/slalom/TerraformDemo/AKIAQINXMUNZQOZILKJS)
```

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

## Run terraform plan

Running terraform plan Terraform prints out the execution plan which describes the actions Terraform will take in order to change your infrastructure to match the configuration.

You should always review the plan before applying it

```bash
terraform plan -out plan.out
```

## Run terraform apply

```bash
terraform apply plan.out
```

## Add a pem key

Lets add a PEM key to login to ec2 instance

```hcl
# Creates a private key
resource "tls_private_key" "this" {
  algorithm = "RSA"
}

# Creates an AWS key pair for ec2 instance
resource "aws_key_pair" "this" {
  key_name   = "tf-demo"
  public_key = tls_private_key.this.public_key_openssh
}
```

Now add the following to `aws_instance`

```hcl
  key_name      = aws_key_pair.this.key_name
```

Add the following to outputs.tf to retrieve the private key from terraform

**NOTE** It is not recommended to add a private key to outputs for production application

```hcl
output "private_key_pem" {
  value     = tls_private_key.this.private_key_pem
  sensitive = true
}
```

## Add security group for ssh access and public access

Create a security group to control what requests can go in and out of the ec2 instance

```hcl
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
```

Update ec2 instance to be public accessible and security group to allow ssh

```hcl
  # This EC2 Instance has a public IP and will be accessible directly from the public Internet
  associate_public_ip_address = true

  # Security groups for ssh
  vpc_security_group_ids = ["${aws_security_group.this.id}"]  
```

Add the public dns to output

```hcl
output "public_dns" {
  value = aws_instance.app_server.public_dns
}
```

No re-run terraform plan

```bash
terraform plan -out plan.out
```

And terraform apply

```bash
terraform apply plan.out
```

Create the pem file

```bash
terraform output -json | jq -r '.private_key_pem.value' > tf-demo.pem
chmod 400 tf-demo.pem
```

Connect to ec2 instance

```bash
ssh -i "tf-demo.pem" ubuntu@ec2-34-215-4-6.us-west-2.compute.amazonaws.com
```

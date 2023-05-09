# Update and Add Resources

Lets update our EC2 instance and add a private key pair so we can ssh into it.

## Add a pem key

Add the resources below to configure a key

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

!!! warning

    It is not recommended to add a private key to outputs for production application


```hcl
output "private_key_pem" {
  value     = tls_private_key.this.private_key_pem
  sensitive = true
}
```

Run terraform fmt, validate

```bash
terraform fmt
terraform validate
```

Run terraform plan

```bash
terraform plan -out=plan.out
```

## Add security group for ssh access

Create a security group to control what requests can go in and out of the ec2 instance by adding below to `main.tf`

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

Update ec2 instance `app_server` in `main.tf` to be public accessible and configure security group to allow ssh

```hcl
  # This EC2 Instance has a public IP and will be accessible directly from the public Internet
  associate_public_ip_address = true

  # Security groups for ssh
  vpc_security_group_ids = ["${aws_security_group.this.id}"]  
```

Add the public dns to `outputs.tf`

```hcl
output "public_dns" {
  value = aws_instance.app_server.public_dns
}
```

Run terraform fmt, validate

```bash
terraform fmt
terraform validate
```

Now re-run terraform plan

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
ssh -i "tf-demo.pem" ubuntu@$(terraform output -json | jq -r '.public_dns.value')
```
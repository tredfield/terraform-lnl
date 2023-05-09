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

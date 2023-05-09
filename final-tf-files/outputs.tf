output "private_key_pem" {
  value     = tls_private_key.this.private_key_pem
  sensitive = true
}

output "public_dns" {
  value = aws_instance.app_server.public_dns
}
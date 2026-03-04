# Generate a fresh RSA 4096 key pair (Terraform keeps the private part in state)
resource "tls_private_key" "bastion" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Register the public key with EC2 so we can SSH in
resource "aws_key_pair" "bastion" {
  key_name   = "${var.name}-bastion-key"
  public_key = tls_private_key.bastion.public_key_openssh
  tags       = local.tags
}
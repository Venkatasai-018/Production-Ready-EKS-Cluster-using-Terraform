# Security Group for Bastion
# - Inbound: SSH (22) only from your allowed_ssh_cidrs (do NOT use 0.0.0.0/0)
# - Outbound: open (for updates and EKS API access via VPC)
resource "aws_security_group" "bastion" {
  name        = "${var.name}-bastion-sg"
  description = "SSH access to bastion from allowlisted CIDRs"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH from allowlist"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}
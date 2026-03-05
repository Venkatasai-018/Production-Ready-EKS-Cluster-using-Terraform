# Put Bastion in a PUBLIC subnet, with a public IP so you can SSH to it.
# Bootstrap installs awscli + kubectl so you can verify the cluster.
locals {
  bastion_subnet_id = module.vpc.public_subnets[0]
}

resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.al2023.id
  instance_type               = "t3.small"
  subnet_id                   = local.bastion_subnet_id
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  key_name                    = aws_key_pair.bastion.key_name
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.bastion.name

  user_data = <<-EOF
    #!/bin/bash
    set -euo pipefail
    dnf -y update
    dnf -y install awscli curl tar gzip
    curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    rm -f kubectl
  EOF

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = merge(local.tags, { Name = "${var.name}-bastion" })
}
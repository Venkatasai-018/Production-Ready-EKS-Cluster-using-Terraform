# VPC refs (optional)
output "vpc_id"             { value = module.vpc.vpc_id }
output "private_subnet_ids" { value = module.vpc.private_subnets }
output "public_subnet_ids"  { value = module.vpc.public_subnets }

# EKS
output "cluster_name" { value = module.eks.cluster_name }
output "cluster_arn"  { value = module.eks.cluster_arn }

# Bastion: how to reach it & how to SSH
output "bastion_public_ip" {
  description = "Public IPv4 for SSH"
  value       = aws_instance.bastion.public_ip
}

output "bastion_private_key_pem" {
  description = "PRIVATE KEY (save to bastion_key.pem; chmod 600)"
  value       = tls_private_key.bastion.private_key_pem
  sensitive   = true
}

output "bastion_ssh_command" {
  description = "Convenience SSH command (after saving the PEM)"
  value       = "ssh -i bastion_key.pem ec2-user@${aws_instance.bastion.public_ip}"
}
# Handy pass-through outputs
output "cluster_name" { value = module.eks_core.cluster_name }
output "bastion_public_ip" { value = module.eks_core.bastion_public_ip }
output "bastion_ssh_command" { value = module.eks_core.bastion_ssh_command }

# Sensitive: PEM used for SSH (save to a file; chmod 600)
output "bastion_private_key_pem" {
  value     = module.eks_core.bastion_private_key_pem
  sensitive = true
}
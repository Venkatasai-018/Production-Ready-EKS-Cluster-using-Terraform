# Call one module that builds VPC + EKS + Bastion in a clean, separated way
module "eks_core" {
  source = "./modules/eks-core"

  name              = var.name
  vpc_cidr          = var.vpc_cidr
  az_count          = var.az_count
  cluster_version   = var.cluster_version
  allowed_ssh_cidrs = var.allowed_ssh_cidrs

  node_min_size       = var.node_min_size
  node_desired_size   = var.node_desired_size
  node_max_size       = var.node_max_size
  node_instance_types = var.node_instance_types

  tags = var.tags
}

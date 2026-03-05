# EKS: Private API only (more secure). Bastion (inside VPC) can reach it.
# IRSA enabled. Control-plane logs enabled. One managed node group (3 AZs).
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.name}-eks"
  cluster_version = var.cluster_version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = false

  enable_irsa = true

  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  eks_managed_node_groups = {
    default = {
      min_size       = var.node_min_size
      desired_size   = var.node_desired_size
      max_size       = var.node_max_size
      instance_types = var.node_instance_types
      capacity_type  = "ON_DEMAND"
      ami_type       = "AL2_x86_64"
      labels         = { role = "general" }
      tags           = local.tags
    }
  }

  # Map the Bastion IAM role to cluster-admin so kubectl works right away from the bastion
  access_entries = {
    bastion = {
      principal_arn = aws_iam_role.bastion.arn
      type          = "EC2_LINUX"
      access_policy_associations = {
        admin = {
          access_scope = {
            type = "cluster"
          }
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
        }
      }
    }
  }

  tags = local.tags
}
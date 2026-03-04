output "cluster_id" {
  description = "Kuberntes cluster"
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "Kubernetes cluster endpoint"
  value       = module.eks.cluster_endpoint
}


output "cluster_security_group_id" {
  description = "Kubernetes cluster security group id"
  value       = module.eks.cluster_security_group_id
}

output "oidc_provider_arn" {
  description="OIDC provider ARN for the EKS cluster"
  value=module.eks.oidc_provider_arn
}
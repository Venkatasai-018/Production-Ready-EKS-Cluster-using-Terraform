# All module inputs


# environment

variable "env" {
 description = "Environment name (e.g. dev, staging, prod)"
 type        = string
 default     = "dev" 
}



# Tags
variable "tags" { 
    description = "Additional tags to apply to resources"
    type = map(string)
    default = {}
}


# availability zones
variable "az_count" {
  description = "Number of availability zones to use for the cluster"
  type        = number
  default     = 3
}


# name

variable "name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-cluster"
}

# VPC CIDR

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# EKS cluster version
variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.27"
}

# EKS node group settings
variable "node_instance_types" {
  description = "List of EC2 instance types for EKS nodes"
  type        = list(string)
  default     = ["t3.medium"]
}

# EKS node group size settings
variable "node_min_size" {
  description = "Minimum number of nodes in the EKS node group"
  type        = number
  default     = 2
}

variable "node_desired_size" {
  description = "Desired number of nodes in the EKS node group"
  type        = number
  default     = 3
}

variable "node_max_size" {
  description = "Maximum number of nodes in the EKS node group"
  type        = number
  default     = 4
}

# Allowed SSH CIDRs for Bastion access
variable "allowed_ssh_cidrs" {
  description = "List of CIDR blocks allowed to SSH into the bastion host (do NOT use)"
  type        = list(string)     
}
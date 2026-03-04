variable "aws_region" {
  type=string
  description="The AWS region where the EKS cluster will be created."
}

variable "env"{
    type=string
    description="The environment for which the EKS cluster is being created (e.g., dev, staging, prod)."
}

variable "vpc_cider"{
    type=string
    description="The CIDR block for the VPC"
}

variable "public_subnet" {
  type=list
  description = "The Public subnet CIDR Range"
}

variable "private_subnet" {
  type=list
  description = "The Private subnet CIDR Range"
}

variable "kubernetes_version" {
  type    = string
  default = "1.27"
  description = "The Kubernetes version for the EKS cluster."
}
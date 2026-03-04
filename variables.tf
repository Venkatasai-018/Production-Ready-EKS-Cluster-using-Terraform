
# Region for all resources
variable "region" {
  type    = string
  default = "ap-south-1"
}

# Simple name/env prefix (e.g., "prod", "staging")
variable "name" {
  type    = string
  default = "prod"
}

# VPC shape
variable "vpc_cidr" {
  type    = string
  default = "10.20.0.0/16"
}
variable "az_count" {
  type    = number
  default = 3
}

# EKS version (set to your org-approved version)
variable "cluster_version" {
  type    = string
  default = "1.29"
}

# SECURITY: only these CIDRs can SSH into bastion
# e.g., ["203.0.113.10/32"] for your office/VPN public IP
variable "allowed_ssh_cidrs" {
  type = list(string)
}

# Node group sizing/types (baseline; adjust anytime)
variable "node_min_size" {
  type    = number
  default = 3
}
variable "node_desired_size" {
  type    = number
  default = 3
}
variable "node_max_size" {
  type    = number
  default = 6
}
variable "node_instance_types" {
  type    = list(string)
  default = ["t3.micro"]
}

# Optional tags (cost center, owner, etc.)
variable "tags" {
  type    = map(string)
  default = {}
}
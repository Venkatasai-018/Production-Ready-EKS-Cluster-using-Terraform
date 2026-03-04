# all available data sources for EKS

# all available data from AWS zones

data "aws_availability_zones" "available" {
  state = "available"
}

#compute the number of availability zones to use for the cluster


# Compute the AZ list we will actually use
locals {
  azs = slice(data.aws_availability_zones.available.names, 0, var.az_count)
}


# List of  AMI images


# Amazon Linux 2023 AMI for Bastion
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["137112412989"] # Amazon
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

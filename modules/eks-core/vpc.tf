# VPC with public + private subnets in each AZ
# - Private subnets: EKS nodes + private endpoint access
# - Public subnets:  Bastion (and future ALBs if needed)
# - NAT per AZ:      production HA
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.8"

  name = "${var.name}-vpc"
  cidr = var.vpc_cidr
  azs  = local.azs

# Private subnets are created by dividing the VPC CIDR block into /28 subnets (4 bits added to VPC prefix)
# using cidrsubnet function with newbits=4. The loop iterates az_count times, creating one subnet
# per availability zone (i=0,1,2...) with sequential network addresses.
#
# Public subnets are created by dividing the VPC CIDR block into /24 subnets (8 bits added to VPC prefix)
# using cidrsubnet function with newbits=8. The loop offset starts at 200 (200+i) to ensure public subnets
# use completely different address ranges than private subnets, preventing IP conflicts across az_count
# availability zones.
#
# Example: If vpc_cidr="10.0.0.0/16" and az_count=3:
# - Private: 10.0.0.0/28, 10.0.1.0/28, 10.0.2.0/28
# - Public: 10.0.200.0/24, 10.0.201.0/24, 10.0.202.0/24
  private_subnets = [for i in range(var.az_count) : cidrsubnet(var.vpc_cidr, 4, i)]
  public_subnets  = [for i in range(var.az_count) : cidrsubnet(var.vpc_cidr, 8, 200 + i)]

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

  create_igw           = true
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = local.tags
}
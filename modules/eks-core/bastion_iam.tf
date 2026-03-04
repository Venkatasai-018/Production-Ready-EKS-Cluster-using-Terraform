# Bastion Host IAM Configuration
# This module sets up minimal IAM permissions for a Bastion EC2 instance to interact with EKS clusters.
#
# Components:
#
# data "aws_iam_policy_document" "ec2_assume"
#   - Defines the trust relationship allowing EC2 service to assume the bastion IAM role
#   - Required so EC2 instances can use the role's permissions
#
# resource "aws_iam_role" "bastion"
#   - Creates the IAM role for the bastion host
#   - Establishes trust with EC2 service via the assume role policy
#   - Tagged with local tags for resource management
#
# data "aws_iam_policy_document" "bastion_min"
#   - Defines minimal permissions policy for the bastion host
#   - Grants eks:DescribeCluster action on all EKS resources
#   - Required for 'aws eks update-kubeconfig' command to retrieve cluster information
#
# resource "aws_iam_policy" "bastion_min"
#   - Creates the IAM policy from the policy document
#   - This policy is attached to the bastion role to grant permissions
#
# resource "aws_iam_role_policy_attachment" "bastion_min"
#   - Attaches the minimal policy to the bastion IAM role
#   - Enables the bastion EC2 instances to describe EKS clusters
#
# resource "aws_iam_instance_profile" "bastion"
#   - Creates an instance profile that ties the bastion role to EC2 instances
#   - Required to pass the IAM role to EC2 instances at launch time
# Minimal IAM for Bastion:
# - EC2 assume role
# - Policy to Describe EKS (used by aws eks update-kubeconfig)


data "aws_iam_policy_document" "ec2_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "bastion" {
  name               = "${var.name}-bastion-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume.json
  tags               = local.tags
}

data "aws_iam_policy_document" "bastion_min" {
  statement {
    sid       = "EKSDescribeCluster"
    actions   = ["eks:DescribeCluster"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "bastion_min" {
  name   = "${var.name}-bastion-min"
  policy = data.aws_iam_policy_document.bastion_min.json
}

resource "aws_iam_role_policy_attachment" "bastion_min" {
  role       = aws_iam_role.bastion.name
  policy_arn = aws_iam_policy.bastion_min.arn
}

resource "aws_iam_instance_profile" "bastion" {
  name = "${var.name}-bastion-profile"
  role = aws_iam_role.bastion.name
}
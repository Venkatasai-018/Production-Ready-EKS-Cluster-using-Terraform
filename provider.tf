terraform {
  required_version = ">= 1.6.0"

  # S3 backend — bucket/key/region are passed via -backend-config at init time
  backend "s3" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.50"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}
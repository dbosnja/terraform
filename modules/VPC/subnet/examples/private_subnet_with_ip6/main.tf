terraform {
  required_version = ">= 1.6.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.40.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
  alias  = "default"
}

locals {
  cidr_block = cidrsubnet(module.vpc.cidr_block, 4, 4)
  # NOTE: aws gives /56 size of generated IPv6 VPC CIDR block
  # but requires fixed /64 size of subnets
  ipv6_cidr_block = cidrsubnet(module.vpc.ipv6_cidr_block, 8, 0)
}

module "vpc" {
  providers = {
    aws.provider = aws.default
  }
  source = "../../../vpc/module"

  cidr_block             = "172.32.0.0/16"
  assign_ipv6_cidr_block = true
  tags = {
    Description = "Custom VPC created to accomodate the subnet"
  }
}

module "private_subnet" {
  providers = {
    aws.provider = aws.default
  }
  source = "../../module"

  public_subnet     = var.public_subnet
  availability_zone = var.availability_zone
  vpc_id            = module.vpc.id
  tags              = var.tags
  cidr_block        = local.cidr_block
  ipv6_cidr_block   = local.ipv6_cidr_block
}

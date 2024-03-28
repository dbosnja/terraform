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

module "vpc" {
  providers = {
    aws.provider = aws.default
  }
  source = "../../module"

  cidr_block             = var.cidr_block
  assign_ipv6_cidr_block = var.assign_ipv6_cidr_block
  enable_dns_hostname    = var.enable_dns_hostname
  tags                   = var.tags
}
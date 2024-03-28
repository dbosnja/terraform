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
  cidr_block = cidrsubnet(data.aws_vpc.default_vpc.cidr_block, 4, 4)
}

data "aws_vpc" "default_vpc" {
  provider = aws.default
  default  = true
}

module "public_subnet_in_default_vpc" {
  providers = {
    aws.provider = aws.default
  }
  source = "../../module"

  public_subnet          = var.public_subnet
  availability_zone      = var.availability_zone
  use_custom_vpc         = false
  tags                   = var.tags
  cidr_block             = local.cidr_block
  allocate_ip6_addresses = false
}

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
  region = var.provider_regions_map[var.deployment_city]
  alias  = "default"
}

module "eip" {
  providers = {
    aws.provider = aws.default
  }
  source = "../../module"
}
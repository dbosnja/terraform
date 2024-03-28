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

module "ephemeral_policy" {
  providers = {
    aws.provider = aws.default
  }
  source              = "../../module"
  cache_policy_config = var.cache_policy_config
}
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

module "response_headers_policies" {
  providers = {
    aws.provider = aws.default
  }
  source                  = "../../module"
  response_headers_policy = var.response_headers_policy
}


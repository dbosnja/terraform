terraform {
  required_version = ">= 1.6.0, < 2.0.0"

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">=5.40.0"
      configuration_aliases = [aws.provider]
    }
  }
}

resource "aws_route53_delegation_set" "ds" {
    provider = aws.provider
}
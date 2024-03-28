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
  alias = "terratest"
}

module "zone" {
  providers = {
    aws.zone_creator      = aws.terratest
    aws.parent_zone_owner = aws.terratest
  }
  source = "../../module"

  apex_zone   = true
  domain_name = var.domain_name
  zone_tags = {
    Name        = "TestZoneModule"
    Description = "Test Zone module as an apex zone"
  }
}
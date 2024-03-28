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

module "zone" {
  providers = {
    aws.zone_creator      = aws.default
    aws.parent_zone_owner = aws.default
  }
  source = "../../../dns_zone/module"

  apex_zone   = true
  domain_name = var.domain_name
  zone_tags   = var.zone_tags
}

module "txt_record" {
  providers = {
    aws.provider = aws.default
  }
  source = "../../module"

  zone_id = module.zone.id
  name    = var.record_name
  type    = var.record_type
  records = var.records
  ttl     = var.record_ttl
}
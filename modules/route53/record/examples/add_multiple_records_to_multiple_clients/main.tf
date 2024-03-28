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

module "all_zones" {
  providers = {
    aws.zone_creator      = aws.default
    aws.parent_zone_owner = aws.default
  }
  source   = "../../../dns_zone/module"
  for_each = { for zc in var.zones_configuration : zc.domain_name => zc }

  domain_name = each.key
  apex_zone   = each.value.apex_zone
  zone_tags   = var.zone_tags
}

module "all_records" {
  providers = {
    aws.provider = aws.default
  }
  source   = "../../module"
  for_each = { for rc in var.records_configuration : rc.full_name => rc }

  zone_id = module.all_zones[each.value.record_owner].id
  name    = each.value.name
  type    = each.value.type
  records = each.value.records
  ttl     = each.value.ttl
}

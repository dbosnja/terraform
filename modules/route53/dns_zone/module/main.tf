#
# Config for zone creation
# To create a new (sub)domain,
# (sub)zone has to be created and in the zone there should be:
#
# NS: If the module is being used to create a subdomain(subzone) then
#     create a NS record with a new set of name servers and
#     associate it with its parent zone
#
#

terraform {
  required_version = ">= 1.6.0, < 2.0.0"

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">=5.40.0"
      configuration_aliases = [aws.zone_creator, aws.parent_zone_owner]
    }
  }
}

locals {
  ns_record_type = "NS"
}

resource "aws_route53_zone" "zone" {
  provider = aws.zone_creator

  name          = var.domain_name
  force_destroy = true
  tags          = var.zone_tags
}

resource "aws_route53_record" "ns_record_for_parent" {
  provider = aws.parent_zone_owner

  count   = var.apex_zone ? 0 : 1
  zone_id = var.parent_zone_id
  name    = var.domain_name
  type    = local.ns_record_type
  ttl     = var.ns_record_ttl
  records = aws_route53_zone.zone.name_servers
}


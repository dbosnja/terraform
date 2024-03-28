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

module "secondary_zone" {
  providers = {
    aws.zone_creator      = aws.terratest
    aws.parent_zone_owner = aws.terratest
  }
  source = "../../module"

  apex_zone      = false
  domain_name    = "dev.${var.domain_name}"
  parent_zone_id = module.zone.id
  zone_tags = {
    Name        = "TestSecondaryZoneModule"
    Description = "Test Zone module as a secondary/sub zone"
  }
}

module "client_zones" {
  providers = {
    aws.zone_creator      = aws.terratest
    aws.parent_zone_owner = aws.terratest
  }
  for_each = toset(var.client_zone_names)
  source   = "../../module"

  apex_zone      = false
  domain_name    = "${each.key}.dev.${var.domain_name}"
  parent_zone_id = module.secondary_zone.id
  zone_tags = {
    Name        = "TestClientZoneModule"
    Description = "Test Zone module as a client subzone"
  }
}
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

locals {
  all_cidr_blocks     = "0.0.0.0/0"
  all_ip6_cidr_blocks = "::/0"

  custom_vpc_main_rtb  = var.use_custom_vpc ? data.aws_vpc.custom_vpc[0].main_route_table_id : null
  default_vpc_main_rtb = data.aws_vpc.default_vpc.main_route_table_id
  normal_rtb           = var.public_subnet ? null : aws_route_table.rtb[0].id
  # use either custom or default VPC route table for public subnets and normal route table for private subnets
  rtb_id = var.public_subnet ? (var.use_custom_vpc ? local.custom_vpc_main_rtb : local.default_vpc_main_rtb) : local.normal_rtb
}

data "aws_vpc" "default_vpc" {
  provider = aws.provider

  default = true
}

data "aws_vpc" "custom_vpc" {
  provider = aws.provider

  count = var.use_custom_vpc ? 1 : 0
  id    = var.vpc_id
}

resource "aws_subnet" "custom_subnet" {
  provider = aws.provider

  availability_zone               = var.availability_zone
  cidr_block                      = var.cidr_block
  vpc_id                          = var.use_custom_vpc ? var.vpc_id : data.aws_vpc.default_vpc.id
  ipv6_cidr_block                 = var.public_subnet ? var.ipv6_cidr_block : null
  assign_ipv6_address_on_creation = var.public_subnet ? var.allocate_ip6_addresses : false
  map_public_ip_on_launch         = var.public_subnet ? true : false
  tags                            = var.tags
}

resource "aws_route_table" "rtb" {
  provider = aws.provider

  count  = var.public_subnet ? 0 : 1
  vpc_id = var.use_custom_vpc ? var.vpc_id : data.aws_vpc.default_vpc.id
}

resource "aws_route_table_association" "rta" {
  provider = aws.provider

  route_table_id = local.rtb_id
  subnet_id      = aws_subnet.custom_subnet.id
}
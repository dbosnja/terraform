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
}

resource "aws_internet_gateway" "igw" {
  provider = aws.provider
}

resource "aws_vpc" "vpc" {
  provider = aws.provider

  cidr_block                       = var.cidr_block
  assign_generated_ipv6_cidr_block = var.assign_ipv6_cidr_block
  enable_dns_hostnames             = var.enable_dns_hostname
  tags                             = var.tags
}

resource "aws_internet_gateway_attachment" "igwa" {
  provider = aws.provider

  vpc_id              = aws_vpc.vpc.id
  internet_gateway_id = aws_internet_gateway.igw.id
}

resource "aws_default_route_table" "drtb" {
  provider = aws.provider

  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    cidr_block = local.all_cidr_blocks
    gateway_id = aws_internet_gateway.igw.id
  }

  # Add IPv6 destinations only if the VPC supports it
  dynamic "route" {
    for_each = toset([for key in [local.all_ip6_cidr_blocks] : key if var.assign_ipv6_cidr_block])

    content {
      ipv6_cidr_block = route.key
      gateway_id      = aws_internet_gateway.igw.id
    }
  }
}
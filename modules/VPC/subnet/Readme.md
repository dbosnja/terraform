# Subnet Module

This folder contains a minimal Terraform configuration deployable on AWS and consisting of following resources:

- one VPC Subnet
- one Route Table
- one Route Table Association

## Why this module?

This module can be used when in need for a VPC subnet. Subnet can be created in a default or a non-default VPC,  
as a private or public and with IPv6 enabled or disabled.  
All configuration options are properly visible in the subnet's route table.

The subnet cannot be created as private with IPv6 enbabled, regardless of the  
underlying VPC since this could lead to various security risks.(All IPv6 addresses are public)

## Quick Start

### Input

#### Required

- `public_subnet` Indicates whether the subnet is public, meaning there's a direct route to the public Internet
- `availability_zone` Name of AZ for the subnet
- `cidr_block` IPv4 CIDR block for the subnet

#### Optional

- `use_custom_vpc` Whether to use a custom/non-default VPC for the subnet; defaults to `true`
- `vpc_id` VPC ID for the subnet. Required for custom VPCs
- `allocate_ip6_addresses` Whether to enable IPv6 addresses in the subnet. Requires VPC supporting it; defaults to `true`
- `ipv6_cidr_block` IPv6 CIDR block for the subnet. Required if `allocate_ip6_addresses` enabled.
- `igw_id` Internet Gateway ID. Required for public subnets
- `tags` Tags for the subnet

Ex1: Create a public subnet with IPv6 enabled in a custom VPC

```
module "public_subnet_with_ip6_in_custom_vpc" {
  source = "module"

  public_subnet     = true
  availability_zone = "us-east-1"
  vpc_id            = vpc-id
  igw_id            = igw-id
  cidr_block        = ip4-cidr-block
  ipv6_cidr_block   = ip6-cidr-block
  tags              = some-tags
}
```

Ex2: Create a public subnet with IPv4 only in a custom VPC

```
module "public_subnet_with_ip4_only_in_custom_vpc" {
  source = "module"

  public_subnet          = true
  availability_zone      = "us-east-1"
  vpc_id                 = vpc-id
  igw_id                 = igw-id
  cidr_block             = ip4-cidr-block
  allocate_ip6_addresses = false
  tags                   = some-tags
}
```

Ex3: Create a private subnet with IPv4 only in a custom VPC

```
module "private_subnet_with_ip4_only_in_custom_vpc" {
  source = "module"

  public_subnet          = false
  availability_zone      = "us-east-1"
  vpc_id                 = vpc-id
  igw_id                 = igw-id
  cidr_block             = ip4-cidr-block
  allocate_ip6_addresses = false
  tags                   = some-tags
}
```

Ex4: Create a public subnet with IPv4 only in a default VPC

```
module "public_subnet_with_ip4_only_in_default_vpc" {
  source = "module"

  public_subnet          = true
  availability_zone      = "us-east-1"
  use_custom_vpc         = false
  cidr_block             = ip4-cidr-block
  allocate_ip6_addresses = false
  tags                   = some-tags
}
```


### Output

- `id` Subnet ID
- `cidr_block` Subnet IPv4 CIDR block
- `ipv6_cidr_block` Subnet IPv6 CIDR block


## Tests

Module comes with a set of go tests.  
Check tests in *test* directory for further instructions.

The following command runs all tests in the module in a verbose mode giving each test a timeout of 30 minutes.  
`go test -v -timeout 30m`

## Author

Domagoj Bošnjak
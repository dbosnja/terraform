# VPC Module

This folder contains a minimal Terraform configuration deployable on AWS and consisting of following resources:

- one VPC
- one Internet Gateway
- one Default Route Table

## Why this module?

This module can be used when in need for a VPC. An Internet Gateway will be attached to the VPC  
and its default route table will be adjusted accordingly. VPC can be created with IPv6 option on,  
meaning it supports IPv6 assignments, in that case the default route table will know how to route  
all IPv6 traffic properly. As per ususal, the default route table always includes the `local` gateway.

At the moment, the created VPC is always public, meaning its default route table has a direct route to the public Internet.

## Quick Start

### Input

#### Required

- `cidr_block` the Range of IPv4 addresses within the VPC
- `assign_ipv6_cidr_block` flag to enable/disable IPv6 within the VPS; if enabled module automatically assigns the IPv6 range

#### Optional

- `enable_dns_hostname` flag to enable/disable DNS name allocations; default `true`
- `tags` tags to assign to VPC

Ex1: Create VPC with IPv6 enabled

```
module "vpc" {
  source = "path-to-module"
  cidr_block             = "172.31.0.0/16"
  assign_ipv6_cidr_block = true
  enable_dns_hostname    = true
  tags                   = {
    Description = "Non-default VPC with IPv6 enabled"
  }
}
```

Ex2: Create VPC with only IPv4

```
module "vpc" {
  source = "path-to-module"
  cidr_block             = "172.31.0.0/16"
  assign_ipv6_cidr_block = false
  enable_dns_hostname    = true
  tags                   = {
    Description = "Non-default VPC with IPv4 only"
  }
}
```


### Output

- `id` VPC ID
- `main_route_table_id` VPC Main route table ID
- `cidr_block` VPC IPv4 allocated CIDR block
- `ipv6_cidr_block` VPC IPv6 allocated CIDR block, if enabled
- `igw_id` VPC Internet Gateway ID


## Tests

Module comes with a set of go tests.  
Check tests in *test* directory for further instructions.

The following command runs all tests in the module in a verbose mode giving each test a timeout of 30 minutes.  
`go test -v -timeout 30m`

## Author

Domagoj Bošnjak
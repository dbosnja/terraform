# DNS Hosted Zone Module

This folder contains a minimal Terraform configuration deployable on AWS and consisting of following resources:

- one Route53 Record

## Why this module?

This module can be used when in need for a DNS record of an arbitrary type.

## Quick Start

### Input

#### Required

- `zone_id` DNS zone owner of the record.
- `name` The name of the record.
- `type` The record type.
- `records` A string list of records.

#### Optional

- `ttl` time to live, ie. cache spec for the record(defaults to 300)

#### Invocation

```
module "txt_record" {
  providers = {
    aws.provider = <a-aws-provider>
  }
  source = "<path-to-module>"

  zone_id = zone-id
  name    = "@"
  type    = "TXT"
  records = ["I like orange juice."]
}
```

Check provided examples in *examples* directory for more details.

#### Tests

Module comes with a set of go tests.  
Check tests in *test* directory for more details.

The following command runs all tests in a module in a verbose mode giving each test a timeout of 30 minutes.  

`go test -v -timeout 30m`

### Author

Domagoj Bošnjak
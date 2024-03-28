# DNS Hosted Zone Module

This folder contains a minimal Terraform configuration deployable on AWS and consisting of following resources:

- one Route53 DNS Zone
- one NS DNS Record type if the created Zone is a sub-zone

## Why this module?

This module can be used when in need for a DNS Zone. It deploys a new DNS zone in an account and
provides 4 name servers distributed throughout 4 different TLDs.  
The overhead of the Name servers is about 20ms.  
Besides Name server, there is also a SOA zone record, automatically generated.

If the created zone is a sub-zone, then the module also creates a new NS DNS Record type and provides the set of name   
servers to its parent zone, in which case its ID is required.

## Quick Start

### Input

#### Required

- `apex_zone` indicates if this zone is a new apex zone
- `domain_name` the corresponding domain name to use with the zone

#### Optional

- `parent_zone_id` parent's zone ID, required if zone to be created is a sub-zone
- `zone_tags` tags to assign to the zone
- `ns_record_ttl` time to live for a NS DNS Record

The module can handle two providers from different accounts, check provided examples in *examples* directory for further instructions.

 `module my_zone {`  
`providers = {`  
`aws.zone_creator      = aws.terraform`  
`aws.parent_zone_owner = aws.terraform`  
`}`   
`  source      = "module"`  
`  apex_zone   = true`  
`  domain_name = "example.com"`  
`}`


`module my_subzone {`  
`providers = {`  
`aws.zone_creator      = aws.terraform`  
`aws.parent_zone_owner = aws.terraform`  
`}`   
`  source      = "module"`  
`  apex_zone   = false`  
`  parent_zone_id = module.my_zone.id`  
`  domain_name = "dev.example.com"`  
`  ns_record_ttl = 3600`  
`}`


### Output

- `id` Zone ID
- `name_servers` List of 4 name servers dedicated to the zone
- `primary_name_server` Primary Name Server
- `subzone_ns_record_fqdn` Fully Qualified Domain Name; non-empty only for subzones
- `subzone_ns_record_name` Subzone Domain Name; non-empty only for subzones


### Tests

Module comes with a set of go tests.  
Check tests in *test* directory for further instructions.

The following command runs all tests in the module in a verbose mode giving each test a timeout of 30 minutes.  
`go test -v -timeout 30m`

## Author

Domagoj Bošnjak
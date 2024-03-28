# ACM Certificate Module

This folder contains a minimal Terraform configuration deployable on AWS and consisting of following resources:

- one ACM Certificate
- several CNAME type of Route53 records
- one ACM Certificate validation

## Why this module?

This module can be used when in need for a TLS/SSL Certificate. In order to prove ownership over the domain,  
couple of CNAME records will be created(as many as the length of domain alternative names).  
In order for domain to be certified, it *has* to be registered by an official registrar.

TLS Certificate can be used with CloudFront or Elastic Load Balancer(ELB).  
For other appliances check AWS documentation.

## Quick Start

### Input

#### Required

- `domain_name` Domain name for which the certification is being created
- `validation_method` Method to use for the validation(DNS/EMAIL)
- `key_algorithm` The algorithm of the public and private key pair to encrypt data
- `subject_alternative_names` Set of domains that should be SANs in the issued certificate
- `certificate_tags` Certificate tags

#### Optional

- `cname_record_ttl` CNAME records time to live; default `172800`

Ex1: Create a TLS Certificate(provider has to be passed explicitely)

```
module "cert" {
  providers = {
    aws.provider = aws.default
  }
  source   = "./module"

  domain_name               = "example.com"
  validation_method         = "DNS"
  key_algorithm             = "EC_prime256v1"
  subject_alternative_names = ["*.example.com", "*.dev.example.com"]
  certificate_tags          = {
    DomainName      = "example.com"
    Description     = "ACM Certificate for apex example.com zone"
    Environment     = "Production"
  }
}
```

### Output

- `certificate_arn` ACM certificate ARN
- `zone_id` DNS zone ID where the certificate and CNAME records are begin applied

## Author

Domagoj Bošnjak
# CloudFront Distribution Module

This folder contains a minimal Terraform configuration deployable on AWS and consisting of following resources:

- one CloudFront Distribution
- pair of A type of Route53 alias Records
- pair of AAAA type of Route53 alias Records(if IPv6 enabled)

## Why this module?

This module can be used when in need for a CloudFront distribution. CloudFront distribution represents AWS CDN  
(Content Delivery Network) which improves end-user experience, reduces latency and load on web servers etc.  
Generated distribution provides a domain name which can be readily used. However, the module will create  
additional alias type of Route53 record, representing an alternative domain name for the Distribution.  
This requires to be the owner of the DNS Zone, having a TLS Certificate and having registered the domain.

The CloudFront distribution argument layout is a complex structure composed of several sub-resources - these resources are laid out below.

## Quick Start

### Input

#### Required

- `aliases` Distribution aliases
- `comment` Distribution comment
- `enabled` Whether the distribution is enabled to accept end user requests for content
- `is_ipv6_enabled` Whether the IPv6 is enabled for the distribution
- `http_version` Maximum HTTP version to support on the distribution
- `price_class` Price class for the distribution
- `default_cache_behavior` Default cache behavior for the distribution
- `ordered_cache_behaviors` Ordered list of cache behaviors resource for this distribution. List from top to bottom in order of precedence
- `origin` Origin configuration
- `restrictions` Distribution geographical restrictions
- `tags` Distribution tags
- `acm_certificate_arn` ACM certificate ARN for the distribution
- `zone_id`DNS zone ID which to deploy the alias records in
- `alias_record_name` The alias record name

#### Optional

- `ssl_support_method` How will the distribution serve the HTTPS requests; default `sni-only`

Ex1: Create CloudFront distribution with IPv6 enabled and an alternative domain name(provider has to be passed explicitly)

```
module "distributions" {
  providers = {
    aws.provider = aws.default
  }
  source   = "./module"

  aliases                 = ["example.com", "www.example.com"]
  comment                 = "My CloudFront Distribution"
  enabled                 = true
  is_ipv6_enabled         = true
  http_version            = "http3"
  price_class             = "PriceClass_100"
  default_cache_behavior  = {
      target_origin_id       = data.aws_instance.example.id
      allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
      cached_methods         = ["GET", "HEAD"]
      compress               = true
      viewer_protocol_policy = "redirect-to-https"
      cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    }
  ordered_cache_behaviors = [
      {
        target_origin_id       = data.aws_instance.example.id
        path_pattern           = "*"
        allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
        cached_methods         = ["GET", "HEAD"]
        compress               = true
        viewer_protocol_policy = "redirect-to-https"
        cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
      },
    ]
  origin = {
      domain_name   = data.aws_instance.example.public_dns
      origin_id     = data.aws_instance.example.id
      origin_shield = {
        enabled              = true
        origin_shield_region = "us-east-1"
      }
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "https-only"
        origin_ssl_protocols   = ["TLSv1"]
      }
  }
  restrictions = {
    geo_restriction = {
      locations        = []
      restriction_type = "none"
    }
  }
  tags = {
      Description = "Lets go"
  }
  acm_certificate_arn = module.cert.certificate_arn
  zone_id             = module.cert.zone_id
  alias_record_name   = "example.com"
}
```

### Output

- `distribution_domain_name` Generated distribution domain name
- `distribution_arn` Distribution ARN

## Author

Domagoj Bošnjak
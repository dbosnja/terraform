# CloudFront Origin Request Policy Module

This folder contains a minimal Terraform configuration deployable on AWS and consisting of following resources:

- one CloudFront Origin Request Policy

## Why this module?

This module can be used when in need for a custom CloudFront Origin Request Policy. Even though AWS provides some built-in origin request policies(e.g. _AllViewer_, _CORS-S3Origin_ etc.), this module provides finer level of control of things like which headers exactly to include/exclude, query params and cookies configuration etc.


## Quick Start

### Input

Object with required and optional keys and/or sub-objects.

#### Required

- `name` Unique name used to identify the origin request policy
- `cookies_config` Object that determines whether any cookies in viewer requests (and if so, which cookies) are included in the origin request key and automatically included in requests that CloudFront sends to the origin
- `headers_config` Object that determines whether any HTTP headers (and if so, which headers) are included in the origin request key and automatically included in requests that CloudFront sends to the origin
- `query_strings_config` Object that determines whether any URL query strings in viewer requests (and if so, which query strings) are included in the origin request key and automatically included in requests that CloudFront sends to the origin

#### Optional
- `comment` Description for the cache policy(default null)
- `cookies` Object that contains a list of cookie names(default [])
- `headers` Object contains a list of header names(default [])
- `query_strings` Configuration parameter that contains a list of query string names(default [])


Ex1: Policy to forward user-agent, referer and origin headers to origin

```
module "origin_request_policy" {
  source = "path-to-module"
  providers = {
    aws.provider = <a-aws-provider>
  }
  origin_request_policy = {
    name    = "UserAgentRefererOriginHeaders"
    comment = "Policy to forward User-Agent, Referer and Origin headers to origin"
    cookies_config = {
      cookie_behavior = "all"
    }
    headers_config = {
      header_behavior = "whitelist"
      headers         = ["User-Agent", "Referer", "Origin"]
    }
    query_strings_config = {
      query_string_behavior = "all"
    }
  }
}
```

Ex2: Policy to forward all headers to origin

```
module "origin_request_policy" {
  source = "path-to-module"
  providers = {
    aws.provider = <a-aws-provider>
  }
  origin_request_policy = {
    name    = "AllViewer"
    comment = "Policy to forward all headers to origin"
    cookies_config = {
      cookie_behavior = "none"
    }
    headers_config = {
      header_behavior = "allViewer"
    }
    query_strings_config = {
      query_string_behavior = "none"
    }
  }
}
```


### Output

- `id` The identifier for the origin request policy
- `etag` The current version of the origin request policy


## Tests

Module comes with a set of go tests.  
Check tests in *test* directory for further instructions.

The following command runs all tests in the module in a verbose mode.  
`go test -v`

## Info

More info on: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_request_policy

## Author

Domagoj Bošnjak
# CloudFront Response Headers Policy Module

This folder contains a minimal Terraform configuration deployable on AWS and consisting of following resources:

- one CloudFront Response Headers Policy

## Why this module?

This module can be used when in need for a custom CloudFront Response Headers Policy. Even though AWS provides some built-in response headers policies(e.g. _SimpleCORS_, _SecurityHeadersPolicy_ etc.), this module provides finer level of control of configuration like which headers exactly to override, which headers to remove etc.


## Quick Start

### Input

Object with required and optional keys and/or sub-objects.

#### Required

- `name` A unique name to identify the response headers policy

#### Optional
- `comment` A comment to describe the response headers policy. The comment cannot be longer than 128 characters(default null)
- `custom_headers_config` list of objects that contain attributes _header_, _override_, _value_(default [])
- `remove_headers_config` list of objects that contain attribute _header_(default [])


Ex1: Policy to override 'Server' and 'Origin' origin headers

```
module "response_headers_policy" {
  source = "path-to-module"
  providers = {
    aws.provider = <a-aws-provider>
  }
  response_headers_policy = {
    name    = "UpdateHeaders"
    comment = "Policy to override 'Server' and 'Origin' origin headers"
    custom_headers_config = [
      {
        header   = "Server"
        override = true
        value    = "Server"
      },
      {
        header   = "Origin"
        override = true
        value    = "Heaven"
      }
    ]
  }
}
```

Ex2: Policy to override and remove some headers from an origin

```
module "response_headers_policy" {
  source = "path-to-module"
  providers = {
    aws.provider = <a-aws-provider>
  }
  response_headers_policy = {
    name    = "UpdateAndRemoveHeaders"
    comment = "Policy to override and remove some headers from an origin"
    custom_headers_config = [
      {
        header   = "Server"
        override = true
        value    = "CreativeServers"
      },
      {
        header   = "Origin"
        override = true
        value    = "Heaven"
      }
    ]
    remove_headers_config = [
      {
        header = "Access-Control"
      },
      {
        header = "Date"
      },
      {
        header = "User-Agent"
      },
      {
        header = "Age"
      },
    ]
  }
}
```


### Output

- `id` The identifier for the response headers policy
- `etag`  The current version of the response headers policy


## Tests

Module comes with a set of go tests.  
Check tests in *test* directory for further instructions.

The following command runs all tests in the module in a verbose mode.  
`go test -v`

## Info

More info on: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_response_headers_policy

## Author

Domagoj Bošnjak


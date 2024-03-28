# CloudFront Cache Policy Module

This folder contains a minimal Terraform configuration deployable on AWS and consisting of following resources:

- one CloudFront Cache Policy

## Why this module?

This module can be used when in need for a custom CloudFront Cache Policy. Even though AWS provides some built-in cache policies, this module provides finer level of control of things like Time to live of cached objects, cached and propagated headers, cookies, query strings etc.


## Quick Start

### Input

Object with required and optional keys and/or sub-objects.

#### Required

- `name`         Unique name used to identify the cache policy
- `comment`      Description for the cache policy
- `min_ttl`      Minimum amount of time, in seconds, that objects should remain in the CloudFront cache before a new request is sent to the origin to check for updates
- `default_ttl`  Amount of time, in seconds, that objects are allowed to remain in the CloudFront cache before CloudFront sends a new request to the origin server to check if the object has been updated
- `max_ttl`      Maximum amount of time, in seconds, that objects stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated
- `cache_key_params` Configuration for including HTTP headers, cookies, and URL query strings in the cache key
- `cookies_config` Whether any cookies in viewer requests are included in the cache key and automatically included in requests that CloudFront sends to the origin
- `headers_config` Whether any HTTP headers are included in the cache key and automatically included in requests that CloudFront sends to the origin
- `query_strings_config` Whether any URL query strings in viewer requests are included in the cache key. It also automatically includes these query strings in requests that CloudFront sends to the origin

#### Optional

- `enable_accept_encoding_brotli`  Flag determines whether the Accept-Encoding HTTP header is included in the cache key and in requests that CloudFront sends to the origin(default true)
- `enable_accept_encoding_gzip`   Whether the Accept-Encoding HTTP header is included in the cache key and in requests sent to the origin by CloudFront(default true)
- `cookies` Object that contains a list of cookie names
- `headers` Object contains a list of header names
- `query_strings` Configuration parameter that contains a list of query string names


Ex1: Create cache policy with very short lived cached objects

```
module "ephemeral_policy" {
  source = "path-to-module"
  providers = {
    aws.provider = <a-aws-provider>
  }
  cache_policy_config = {
    name        = "ephemeral_policy"
    comment     = "Cache policy with very short lived cached objects, from 10-100 seconds. Ideal for sandbox development."
    min_ttl     = 10
    default_ttl = 60
    max_ttl     = 100
    cache_key_params = {
      cookies_config = {
        cookie_behavior = "none"
      }
      headers_config = {
        header_behavior = "none"
      }
      query_strings_config = {
        query_string_behavior = "none"
      }
    }
  }
}
```

Ex2: Create cache policy with very long lived cached objects

```
module "ephemeral_policy" {
  source = "path-to-module"
  providers = {
    aws.provider = <a-aws-provider>
  }
  cache_policy_config = {
    name        = "infinite_policy"
    comment     = "Cache policy with very long lived cached objects, up to 1 year. Ideal for static production files."
    min_ttl     = 1031560000
    default_ttl = 1031560000
    max_ttl     = 1031560000
    cache_key_params = {
      enable_accept_encoding_brotli = false
      enable_accept_encoding_gzip   = false
      cookies_config = {
        cookie_behavior = "none"
      }
      headers_config = {
        header_behavior = "whitelist"
        headers         = ["Accept-Encoding", "Host"]
      }
      query_strings_config = {
        query_string_behavior = "none"
      }
    }
  }
}
```


### Output

- `id` Identifier for the cache policy
- `etag` Current version of the cache policy


## Tests

Module comes with a set of go tests.  
Check tests in *test* directory for further instructions.

The following command runs all tests in the module in a verbose mode.  
`go test -v`


## Author

Domagoj Bošnjak
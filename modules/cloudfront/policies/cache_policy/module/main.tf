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

resource "aws_cloudfront_cache_policy" "accp" {
  name        = var.cache_policy_config.name
  comment     = var.cache_policy_config.comment
  min_ttl     = var.cache_policy_config.min_ttl
  default_ttl = var.cache_policy_config.default_ttl
  max_ttl     = var.cache_policy_config.max_ttl

  parameters_in_cache_key_and_forwarded_to_origin {
    enable_accept_encoding_brotli = var.cache_policy_config.cache_key_params.enable_accept_encoding_brotli
    enable_accept_encoding_gzip   = var.cache_policy_config.cache_key_params.enable_accept_encoding_gzip

    # NOTE: all this loops are dummy loops, they produce a 1 element list
    # if the condition holds and based on that construct the dynamic content.
    # This is introduced since Terraform was keep updating
    # the instance in place with '{}' value. (AWS kept it as null though)
    cookies_config {
      cookie_behavior = var.cache_policy_config.cache_key_params.cookies_config.cookie_behavior
      dynamic "cookies" {
        for_each = [for _ in ["noop"] : _ if length(var.cache_policy_config.cache_key_params.cookies_config.cookies) > 0]

        content {
          items = var.cache_policy_config.cache_key_params.cookies_config.cookies
        }
      }
    }
    headers_config {
      header_behavior = var.cache_policy_config.cache_key_params.headers_config.header_behavior
      dynamic "headers" {
        for_each = [for _ in ["noop"] : _ if length(var.cache_policy_config.cache_key_params.headers_config.headers) > 0]

        content {
          items = var.cache_policy_config.cache_key_params.headers_config.headers
        }
      }
    }
    query_strings_config {
      query_string_behavior = var.cache_policy_config.cache_key_params.query_strings_config.query_string_behavior
      dynamic "query_strings" {
        for_each = [for _ in ["noop"] : _ if length(var.cache_policy_config.cache_key_params.query_strings_config.query_strings) > 0]

        content {
          items = var.cache_policy_config.cache_key_params.query_strings_config.query_strings
        }
      }
    }
  }
}
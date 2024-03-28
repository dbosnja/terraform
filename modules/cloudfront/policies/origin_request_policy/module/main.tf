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

resource "aws_cloudfront_origin_request_policy" "corp" {
  name    = var.origin_request_policy.name
  comment = var.origin_request_policy.comment

  # NOTE: all this loops are dummy loops, they produce a 1 element list
  # if the condition holds and based on that construct the dynamic content.
  # This is introduced since Terraform was keep updating
  # the instance in place with '{}' value. (AWS kept it as null though)
  cookies_config {
    cookie_behavior = var.origin_request_policy.cookies_config.cookie_behavior

    dynamic "cookies" {
      for_each = toset([for _ in ["noop"] : _ if length(var.origin_request_policy.cookies_config.cookies) > 0])
      content {
        items = var.origin_request_policy.cookies_config.cookies
      }
    }
  }
  headers_config {
    header_behavior = var.origin_request_policy.headers_config.header_behavior

    dynamic "headers" {
      for_each = toset([for _ in ["noop"] : _ if length(var.origin_request_policy.headers_config.headers) > 0])
      content {
        items = var.origin_request_policy.headers_config.headers
      }
    }
  }
  query_strings_config {
    query_string_behavior = var.origin_request_policy.query_strings_config.query_string_behavior

    dynamic "query_strings" {
      for_each = toset([for _ in ["noop"] : _ if length(var.origin_request_policy.query_strings_config.query_strings) > 0])
      content {
        items = var.origin_request_policy.query_strings_config.query_strings
      }
    }
  }
}
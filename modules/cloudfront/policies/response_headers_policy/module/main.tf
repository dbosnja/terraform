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

resource "aws_cloudfront_response_headers_policy" "crhp" {
  name    = var.response_headers_policy.name
  comment = var.response_headers_policy.comment

  # NOTE: all this loops are dummy loops, they produce a 1 element list
  # if the condition holds and based on that construct the dynamic content.
  # This is introduced since Terraform was keep updating
  # the instance in place with '{}' value. (AWS kept it as null though)
  dynamic "custom_headers_config" {
    for_each = [for _ in ["noop"] : _ if length(var.response_headers_policy.custom_headers_config) > 0]

    content {
      dynamic "items" {
        for_each = [for item in var.response_headers_policy.custom_headers_config : item]

        content {
          header   = items.value.header
          override = items.value.override
          value    = items.value.value
        }
      }
    }
  }
  dynamic "remove_headers_config" {
    for_each = [for _ in ["noop"] : _ if length(var.response_headers_policy.remove_headers_config) > 0]

    content {
      dynamic "items" {
        for_each = [for item in var.response_headers_policy.remove_headers_config : item]

        content {
          header = items.value.header
        }
      }
    }
  }
}
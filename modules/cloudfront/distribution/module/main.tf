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

locals {
  alias_a_record_type    = "A"
  alias_aaaa_record_type = "AAAA"
}

resource "aws_cloudfront_distribution" "c_distro" {
  provider = aws.provider

  aliases         = var.aliases
  comment         = var.comment
  enabled         = var.enabled
  is_ipv6_enabled = var.is_ipv6_enabled
  http_version    = var.http_version
  price_class     = var.price_class

  default_cache_behavior {
    allowed_methods            = var.default_cache_behavior.allowed_methods
    cached_methods             = var.default_cache_behavior.cached_methods
    compress                   = var.default_cache_behavior.compress
    target_origin_id           = var.default_cache_behavior.target_origin_id
    viewer_protocol_policy     = var.default_cache_behavior.viewer_protocol_policy
    cache_policy_id            = var.default_cache_behavior.cache_policy_id
    origin_request_policy_id   = var.default_cache_behavior.origin_request_policy_id
    response_headers_policy_id = var.default_cache_behavior.response_headers_policy_id
  }

  dynamic "ordered_cache_behavior" {
    for_each = toset(var.ordered_cache_behaviors)

    content {
      path_pattern               = ordered_cache_behavior.key.path_pattern
      allowed_methods            = ordered_cache_behavior.key.allowed_methods
      cached_methods             = ordered_cache_behavior.key.cached_methods
      compress                   = ordered_cache_behavior.key.compress
      target_origin_id           = ordered_cache_behavior.key.target_origin_id
      viewer_protocol_policy     = ordered_cache_behavior.key.viewer_protocol_policy
      cache_policy_id            = ordered_cache_behavior.key.cache_policy_id
      origin_request_policy_id   = ordered_cache_behavior.key.origin_request_policy_id
      response_headers_policy_id = ordered_cache_behavior.key.response_headers_policy_id
    }
  }

  origin {
    domain_name = var.origin.domain_name
    origin_id   = var.origin.origin_id

    origin_shield {
      enabled              = var.origin.origin_shield.enabled
      origin_shield_region = var.origin.origin_shield.origin_shield_region
    }

    custom_origin_config {
      http_port              = var.origin.custom_origin_config.http_port
      https_port             = var.origin.custom_origin_config.https_port
      origin_protocol_policy = var.origin.custom_origin_config.origin_protocol_policy
      origin_ssl_protocols   = var.origin.custom_origin_config.origin_ssl_protocols
    }
  }

  restrictions {
    geo_restriction {
      locations        = var.restrictions.geo_restriction.locations
      restriction_type = var.restrictions.geo_restriction.restriction_type
    }
  }

  tags = var.tags

  viewer_certificate {
    acm_certificate_arn = var.acm_certificate_arn
    ssl_support_method  = var.ssl_support_method
  }
}

resource "aws_route53_record" "a_alias" {
  provider = aws.provider

  zone_id = var.zone_id
  name    = var.alias_record_name
  type    = local.alias_a_record_type

  alias {
    name                   = aws_cloudfront_distribution.c_distro.domain_name
    zone_id                = aws_cloudfront_distribution.c_distro.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "a_alias_www" {
  provider = aws.provider

  zone_id = var.zone_id
  name    = "www.${var.alias_record_name}"
  type    = local.alias_a_record_type

  alias {
    name                   = aws_cloudfront_distribution.c_distro.domain_name
    zone_id                = aws_cloudfront_distribution.c_distro.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "aaaa_alias" {
  count    = var.is_ipv6_enabled ? 1 : 0
  provider = aws.provider

  zone_id = var.zone_id
  name    = var.alias_record_name
  type    = local.alias_aaaa_record_type

  alias {
    name                   = aws_cloudfront_distribution.c_distro.domain_name
    zone_id                = aws_cloudfront_distribution.c_distro.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "aaaa_alias_www" {
  count    = var.is_ipv6_enabled ? 1 : 0
  provider = aws.provider

  zone_id = var.zone_id
  name    = "www.${var.alias_record_name}"
  type    = local.alias_aaaa_record_type

  alias {
    name                   = aws_cloudfront_distribution.c_distro.domain_name
    zone_id                = aws_cloudfront_distribution.c_distro.hosted_zone_id
    evaluate_target_health = false
  }
}


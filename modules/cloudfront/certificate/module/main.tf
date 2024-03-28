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

data "aws_route53_zone" "zone" {
  provider = aws.provider
  name     = var.domain_name
}

# Certificate creation and validation
resource "aws_acm_certificate" "cert" {
  provider = aws.provider

  domain_name               = var.domain_name
  validation_method         = var.validation_method
  key_algorithm             = var.key_algorithm
  subject_alternative_names = var.subject_alternative_names
  tags                      = var.certificate_tags
}

resource "aws_route53_record" "cname" {
  provider = aws.provider
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = var.cname_record_ttl
  type            = each.value.type
  zone_id         = data.aws_route53_zone.zone.id
}

# requires domain to be registered
resource "aws_acm_certificate_validation" "acm_validation" {
  provider = aws.provider

  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cname : record.fqdn]
}
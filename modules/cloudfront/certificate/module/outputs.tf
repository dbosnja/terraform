output "certificate_arn" {
  description = "ACM certificate ARN"
  value       = aws_acm_certificate.cert.arn
}

output "zone_id" {
  description = "DNS zone ID where the certificate and CNAME records are begin applied"
  value       = data.aws_route53_zone.zone.id
}
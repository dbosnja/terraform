output "distribution_domain_name" {
  description = "Generated distribution domain name"
  value       = aws_cloudfront_distribution.c_distro.domain_name
}

output "distribution_arn" {
  description = "Distribution ARN"
  value       = aws_cloudfront_distribution.c_distro.arn
}
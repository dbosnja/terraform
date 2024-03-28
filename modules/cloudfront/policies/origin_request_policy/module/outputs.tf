output "id" {
  description = "Identifier for the origin request policy"
  value       = aws_cloudfront_origin_request_policy.corp.id
}

output "etag" {
  description = "Current version of the origin request policy"
  value       = aws_cloudfront_origin_request_policy.corp.etag
}
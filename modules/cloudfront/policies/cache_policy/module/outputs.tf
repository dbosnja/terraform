output "id" {
  description = "Identifier for the cache policy"
  value       = aws_cloudfront_cache_policy.accp.id
}

output "etag" {
  description = "Current version of the cache policy"
  value       = aws_cloudfront_cache_policy.accp.etag
}
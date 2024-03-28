output "id" {
  description = "Identifier for the cache policy"
  value       = module.origin_request_policy.id
}

output "etag" {
  description = "Current version of the cache policy"
  value       = module.origin_request_policy.etag
}
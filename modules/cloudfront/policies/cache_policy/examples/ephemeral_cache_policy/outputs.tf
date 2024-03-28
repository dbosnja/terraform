output "id" {
  description = "Identifier for the cache policy"
  value       = module.ephemeral_policy.id
}

output "etag" {
  description = "Current version of the cache policy"
  value       = module.ephemeral_policy.etag
}
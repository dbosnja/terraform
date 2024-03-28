output "id" {
  description = "Identifier for the reponse headers policy"
  value       = module.response_headers_policies.id
}

output "etag" {
  description = "Current version of the reponse headers policy"
  value       = module.response_headers_policies.etag
}


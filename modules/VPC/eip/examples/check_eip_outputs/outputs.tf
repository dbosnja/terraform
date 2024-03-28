output "public_ip" {
  description = "Public IP of the eip resource"
  value       = module.eip.public_ip
}

output "id" {
  description = "ID of the eip resource"
  value       = module.eip.id
}
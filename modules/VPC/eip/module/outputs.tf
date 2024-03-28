output "public_ip" {
  description = "Public IP of the eip resource"
  value       = aws_eip.eip.public_ip
}

output "id" {
  description = "ID of the eip resource"
  value       = aws_eip.eip.id
}
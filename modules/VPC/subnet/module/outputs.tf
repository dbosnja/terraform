output "id" {
  description = "Subnet ID"
  value       = aws_subnet.custom_subnet.id
}

output "cidr_block" {
  description = "Subnet IPv4 CIDR block"
  value       = aws_subnet.custom_subnet.cidr_block
}

output "ipv6_cidr_block" {
  description = "Subnet IPv6 CIDR block"
  value       = aws_subnet.custom_subnet.ipv6_cidr_block
}
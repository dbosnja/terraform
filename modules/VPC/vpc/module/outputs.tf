output "id" {
  description = "VPC ID"
  value       = aws_vpc.vpc.id
}

output "main_route_table_id" {
  description = "Main route table ID"
  value       = aws_vpc.vpc.main_route_table_id
}

output "cidr_block" {
  description = "VPC IPv4 CIDR block"
  value       = aws_vpc.vpc.cidr_block
}

output "ipv6_cidr_block" {
  description = "VPC IPv6 CIDR block"
  value       = aws_vpc.vpc.ipv6_cidr_block
}

output "igw_id" {
  description = "VPC Internet Gateway ID"
  value       = aws_internet_gateway.igw.id
}
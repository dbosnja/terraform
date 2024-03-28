output "id" {
  description = "VPC ID"
  value       = module.vpc.id
}

output "main_route_table_id" {
  description = "Main route table ID for the VPC"
  value       = module.vpc.main_route_table_id
}

output "cidr_block" {
  description = "VPC IPv4 CIDR block"
  value       = module.vpc.cidr_block
}

output "ipv6_cidr_block" {
  description = "VPC IPv6 CIDR block"
  value       = module.vpc.ipv6_cidr_block
}
output "public_subnet_id" {
  value = module.public_subnet.id
}

output "cidr_block" {
  value = module.public_subnet.cidr_block
}

output "ipv6_cidr_block" {
  value = module.public_subnet.ipv6_cidr_block
}
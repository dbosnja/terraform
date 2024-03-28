output "private_subnet_id" {
  value = module.private_subnet_in_default_vpc.id
}

output "cidr_block" {
  value = module.private_subnet_in_default_vpc.cidr_block
}
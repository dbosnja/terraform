output "public_subnet_id" {
  value = module.public_subnet_in_default_vpc.id
}

output "cidr_block" {
  value = module.public_subnet_in_default_vpc.cidr_block
}
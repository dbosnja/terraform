output "private_subnet_id" {
  value = module.private_subnet.id
}

output "cidr_block" {
  value = module.private_subnet.cidr_block
}
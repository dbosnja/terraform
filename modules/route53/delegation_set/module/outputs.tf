output "name_servers" {
  value = aws_route53_delegation_set.ds.name_servers
}

output "id" {
  value = aws_route53_delegation_set.ds.id
}
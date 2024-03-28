output "id" {
  value = aws_route53_zone.zone.zone_id
}

output "name_servers" {
  value = aws_route53_zone.zone.name_servers
}

output "primary_name_server" {
  value = aws_route53_zone.zone.primary_name_server
}

output "subzone_ns_record_fqdn" {
  value = var.apex_zone ? "" : aws_route53_record.ns_record_for_parent[0].fqdn
}

output "subzone_ns_record_name" {
  value = var.apex_zone ? "" : aws_route53_record.ns_record_for_parent[0].name
}
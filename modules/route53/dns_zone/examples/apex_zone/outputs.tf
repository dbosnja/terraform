output "zone_id" {
  value = module.zone.id
}

output "name_servers" {
  value = module.zone.name_servers
}

output "primary_name_server" {
  value = module.zone.primary_name_server
}

output "subzone_ns_record_fqdn" {
  value = module.zone.subzone_ns_record_fqdn
}

output "subzone_ns_record_name" {
  value = module.zone.subzone_ns_record_name
}

output "zone_id" {
  value = module.zone.id
}

output "sub_zone_id" {
  value = module.secondary_zone.id
}

output "name_servers" {
  value = module.zone.name_servers
}

output "subzone_name_servers" {
  value = module.secondary_zone.name_servers
}

output "primary_name_server" {
  value = module.zone.primary_name_server
}

output "subzone_primary_name_server" {
  value = module.secondary_zone.primary_name_server
}

output "subzone_ns_record_fqdn" {
  value = module.secondary_zone.subzone_ns_record_fqdn
}

output "subzone_ns_record_name" {
  value = module.secondary_zone.subzone_ns_record_name
}
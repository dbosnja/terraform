output "client_zone_ids" {
  value = [for cz in module.client_zones : cz.id]
}

output "client_zone_subzone_ns_record_fqdns" {
  value = [for cz in module.client_zones : cz.subzone_ns_record_fqdn]
}

output "client_zone_subzone_ns_record_names" {
  value = [for cz in module.client_zones : cz.subzone_ns_record_name]
}
output "fqdns" {
  value = [for r in module.all_records : r.fqdn]
}

output "names" {
  value = [for r in module.all_records : r.name]
}
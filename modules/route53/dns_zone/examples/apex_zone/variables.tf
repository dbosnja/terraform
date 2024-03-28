variable "domain_name" {
  type        = string
  description = "The domain name with the TLD"
  default     = "l8bloom.hr"
}

variable "zone_tags" {
  type        = map(string)
  description = "Tags to apply to the zone"
  default = {
    Name        = "TestZoneModule"
    Description = "Test Zone module as a root zone"
  }
}
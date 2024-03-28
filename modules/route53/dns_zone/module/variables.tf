### REQUIRED PARAMETERS ###

variable "apex_zone" {
  type        = bool
  description = "Indicates if this zone is the apex/root zone(example.com) or some of its subdomains(subzones)(dev.example.com)"
}

variable "domain_name" {
  type        = string
  description = "Domain name to use with the zone. Always use all lower-case! Otherwise Terraform will force replacement!"
}

### OPTIONAL PARAMETERS ###

variable "parent_zone_id" {
  type        = string
  description = "ID of the parent zone. This is required for all non-apex zones"
  default     = ""
}

variable "zone_tags" {
  type        = map(string)
  description = "Tags to apply to the zone"
  default = {
    name        = "DNS zone"
    description = "DNS Management zone"
  }
}

variable "ns_record_ttl" {
  type        = number
  description = "Time To Live for NS type of records"
  default     = 172800
}


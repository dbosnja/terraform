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

variable "record_name" {
  type        = string
  description = "The name of the record."
  default     = ""
}

variable "record_type" {
  type        = string
  description = "The record type."
  default     = "TXT"
}

variable "records" {
  type        = list(string)
  description = "A string list of records."
  default     = ["I like smoothies."]
}

### OPTIONAL PARAMETERS ###

variable "record_ttl" {
  type        = number
  description = "Time To Live(TTL) for of the record."
  default     = 300
}
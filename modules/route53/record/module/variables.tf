### REQUIRED PARAMETERS ###

variable "zone_id" {
  type        = string
  description = "DNS zone owner of the record."
}

variable "name" {
  type        = string
  description = "The name of the record."
}

variable "type" {
  type        = string
  description = "The record type."
}

variable "records" {
  type        = list(string)
  description = "A string list of records."
}

### OPTIONAL PARAMETERS ###

variable "ttl" {
  type        = number
  description = "Time To Live(TTL) of the record."
  default     = 300
}
### REQUIRED PARAMETERS ###

variable "domain_name" {
  type        = string
  description = "Domain name for which the certification is being created."
}

variable "validation_method" {
  type        = string
  description = "Method to use for the validation(DNS/EMAIL)"
}

variable "key_algorithm" {
  type        = string
  description = "The algorithm of the public and private key pair to encrypt data."
}

variable "subject_alternative_names" {
  type        = list(string)
  description = "Set of domains that should be SANs in the issued certificate."
}

variable "certificate_tags" {
  type        = map(any)
  description = "Certificate tags."
}

### OPTIONAL PARAMETERS ###

variable "cname_record_ttl" {
  type        = number
  description = "CNAME records time to live."
  default     = 172800
}
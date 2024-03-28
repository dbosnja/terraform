### REQUIRED PARAMETERS ###

variable "cidr_block" {
  type        = string
  description = "IPv4 CIDR block for the VPC"
}

variable "assign_ipv6_cidr_block" {
  type        = bool
  description = "Flag to enable/disable IPv6 CIDR block for the VPC"
}

### OPTIONAL PARAMETERS ###

variable "enable_dns_hostname" {
  type        = bool
  description = "Flag to enable/disable DNS hostnames in the VPC"
  default     = true
}

variable "tags" {
  type        = map(any)
  description = "Tags for the VPC"
  default = {
    Description = "Custom VPC managed by Terraform"
  }
}
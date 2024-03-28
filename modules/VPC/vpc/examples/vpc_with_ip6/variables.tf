variable "cidr_block" {
  default = "172.32.0.0/16"
}

variable "assign_ipv6_cidr_block" {
  default = true
}

variable "enable_dns_hostname" {
  default = true
}

variable "tags" {
  default = {
    Description = "Custom VPC managed by Terraform"
  }
}
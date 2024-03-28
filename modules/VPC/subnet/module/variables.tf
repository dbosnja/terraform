### REQUIRED PARAMETERS ###

variable "public_subnet" {
  type        = bool
  description = "Indicates whether the subnet is public, meaning there's a direct route to the public Internet"
}

variable "availability_zone" {
  type        = string
  description = "Name of AZ for the subnet"
}

variable "cidr_block" {
  type        = string
  description = "IPv4 CIDR block for the subnet"
}

### OPTIONAL PARAMETERS ###

variable "use_custom_vpc" {
  type        = bool
  description = "Whether to use a custom or a default VPC for the subnet"
  default     = true
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the subnet. Required for custom VPCs"
  default     = null
}

variable "allocate_ip6_addresses" {
  type        = bool
  description = "Whether to enable IPv6 addresses in the subnet. Requires VPC supporting it."
  default     = true
}

variable "ipv6_cidr_block" {
  type        = string
  description = "IPv6 CIDR block for the subnet. Required if `allocate_ip6_addresses` enabled."
  default     = null
}

variable "igw_id" {
  type        = string
  description = "Internet Gateway ID. Required for public subnets"
  default     = null
}

variable "tags" {
  type        = map(any)
  description = "Tags for the subnet"
  default = {
    Description = "Custom subnet managed by Terraform"
  }
}

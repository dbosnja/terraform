variable "public_subnet" {
  default = false
}

variable "availability_zone" {
  default = "eu-central-1a"
}

variable "tags" {
  type        = map(any)
  description = "Tags for the subnet"
  default = {
    Description = "Custom subnet managed by Terraform"
  }
}
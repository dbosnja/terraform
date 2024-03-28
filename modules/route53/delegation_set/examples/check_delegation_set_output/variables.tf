variable "deployment_city" {
  type        = string
  description = "The city/state where the resources are going to be deployed"
  default     = "Frankfurt"
}

variable "provider_regions_map" {
  type        = map(string)
  description = "The map from a city/state to their normalized code names"
  default = {
    Frankfurt = "eu-central-1"
  }
}
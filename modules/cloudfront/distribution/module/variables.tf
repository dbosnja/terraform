### REQUIRED PARAMETERS ###

variable "aliases" {
  type        = list(string)
  description = "Distribution aliases."
}

variable "comment" {
  type        = string
  description = "Distribution comment."
}

variable "enabled" {
  type        = bool
  description = "Whether the distribution is enabled to accept end user requests for content."
}

variable "is_ipv6_enabled" {
  type        = bool
  description = "Whether the IPv6 is enabled for the distribution."
}

variable "http_version" {
  type        = string
  description = "Maximum HTTP version to support on the distribution."
}

variable "price_class" {
  type        = string
  description = "Price class for the distribution."
}

variable "default_cache_behavior" {
  type = object({
    allowed_methods            = list(string)
    cached_methods             = list(string)
    compress                   = bool
    target_origin_id           = string
    viewer_protocol_policy     = string
    cache_policy_id            = string
    origin_request_policy_id   = optional(string)
    response_headers_policy_id = optional(string)
  })
  description = "Default cache behavior for the distribution."
}

variable "ordered_cache_behaviors" {
  type = list(object({
    path_pattern           = string
    allowed_methods        = list(string)
    cached_methods         = list(string)
    compress               = bool
    target_origin_id       = string
    viewer_protocol_policy = string
    # NOTE: One of cache_policy_id or origin_request_policy_id is required
    cache_policy_id            = optional(string)
    origin_request_policy_id   = optional(string)
    response_headers_policy_id = optional(string)
  }))
  description = "Ordered list of cache behaviors resource for this distribution. List from top to bottom in order of precedence."
}

variable "origin" {
  type = object({
    domain_name = string
    origin_id   = string

    origin_shield = object({
      enabled              = bool
      origin_shield_region = string
    })

    custom_origin_config = object({
      http_port              = number
      https_port             = number
      origin_protocol_policy = string
      origin_ssl_protocols   = list(string)
    })
  })
  description = "Origin configuration."
}

variable "restrictions" {
  type        = map(any)
  description = "Distribution geographical restrictions."
}

variable "tags" {
  type        = map(any)
  description = "Distribution tags."
}

variable "acm_certificate_arn" {
  type        = string
  description = "ACM certificate ARN for the distribution."
}

variable "zone_id" {
  type        = string
  description = "DNS zone ID which to deploy the alias records in."
}

variable "alias_record_name" {
  type        = string
  description = "The alias record name."
}

### OPTIONAL PARAMETERS ###

# NOTE: do *not* change this value
variable "ssl_support_method" {
  type        = string
  description = "How will the distribution serve the HTTPS requests."
  default     = "sni-only"
}


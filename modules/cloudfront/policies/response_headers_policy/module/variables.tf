### REQUIRED PARAMETERS ###

# TODO: extend the API with cors_config, security_headers_config and server_timing_headers_config
variable "response_headers_policy" {
  description = "Configuration object for Cloudfront response headers policy"
  type = object({
    name    = string
    comment = optional(string)
    # NOTE: one of cors_config, custom_headers_config, remove_headers_config,
    # security_headers_config, server_timing_headers_config must be specified
    custom_headers_config = optional(list(object({
      header   = string
      override = bool
      value    = string
    })), [])
    remove_headers_config = optional(list(object({
      header = string
    })), [])
  })
}


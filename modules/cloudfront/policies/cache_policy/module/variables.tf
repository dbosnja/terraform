### REQUIRED PARAMETERS ###

variable "cache_policy_config" {
  description = "Configuration object for Cloudfront cache policy"
  type = object({
    name        = string
    comment     = string
    min_ttl     = number
    default_ttl = number
    max_ttl     = number

    cache_key_params = object({
      enable_accept_encoding_brotli = optional(bool, true)
      enable_accept_encoding_gzip   = optional(bool, true)

      cookies_config = object({
        cookie_behavior = string
        cookies         = optional(list(string), [])
      })

      headers_config = object({
        header_behavior = string
        headers         = optional(list(string), [])
      })

      query_strings_config = object({
        query_string_behavior = string
        query_strings         = optional(list(string), [])
      })
    })
  })
}
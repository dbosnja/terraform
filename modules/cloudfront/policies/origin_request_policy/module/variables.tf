### REQUIRED PARAMETERS ###

variable "origin_request_policy" {
  description = "Configuration object for Cloudfront origin request policy"
  type = object({
    name    = string
    comment = optional(string)
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
}


variable "cache_policy_config" {
  default = {
    name        = "ephemeral_policy"
    comment     = "Cache policy with very short lived cached objects, from 10-100 seconds. Ideal for sandbox development."
    min_ttl     = 10
    default_ttl = 60
    max_ttl     = 100
    cache_key_params = {
      cookies_config = {
        cookie_behavior = "none"
      }
      headers_config = {
        header_behavior = "none"
      }
      query_strings_config = {
        query_string_behavior = "none"
      }
    }
  }
}
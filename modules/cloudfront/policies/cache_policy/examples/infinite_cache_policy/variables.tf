variable "cache_policy_config" {
  default = {
    name        = "infinite_policy"
    comment     = "Cache policy with very long lived cached objects, up to 1 year. Ideal for static production files."
    min_ttl     = 1031560000
    default_ttl = 1031560000
    max_ttl     = 1031560000
    cache_key_params = {
      enable_accept_encoding_brotli = false
      enable_accept_encoding_gzip   = false
      cookies_config = {
        cookie_behavior = "none"
      }
      headers_config = {
        header_behavior = "whitelist"
        headers         = ["Accept-Encoding", "Host"]
      }
      query_strings_config = {
        query_string_behavior = "none"
      }
    }
  }
}
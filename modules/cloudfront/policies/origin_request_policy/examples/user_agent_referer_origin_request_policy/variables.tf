variable "origin_request_policy" {
  default = {
    name    = "UserAgentRefererOriginHeaders"
    comment = "Policy to forward User-Agent, Referer and Origin headers to origin"
    cookies_config = {
      cookie_behavior = "all"
    }
    headers_config = {
      header_behavior = "whitelist"
      headers         = ["User-Agent", "Referer", "Origin"]
    }
    query_strings_config = {
      query_string_behavior = "all"
    }
  }
}


variable "origin_request_policy" {
  default = {
    name    = "AllViewer"
    comment = "Policy to forward all headers to origin"
    cookies_config = {
      cookie_behavior = "none"
    }
    headers_config = {
      header_behavior = "allViewer"
    }
    query_strings_config = {
      query_string_behavior = "none"
    }
  }
}


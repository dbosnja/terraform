variable "response_headers_policy" {
  default = {
    name    = "UpdateHeaders"
    comment = "Policy to override 'Server' and 'Origin' origin headers"
    custom_headers_config = [
      {
        header   = "Server"
        override = true
        value    = "Server"
      },
      {
        header   = "Origin"
        override = true
        value    = "Heaven"
      }
    ]
  }
}


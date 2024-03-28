variable "response_headers_policy" {
  default = {
    name    = "UpdateAndRemoveHeaders"
    comment = "Policy to override and remove some headers from an origin"
    custom_headers_config = [
      {
        header   = "Server"
        override = true
        value    = "CreativeServers"
      },
      {
        header   = "Origin"
        override = true
        value    = "Heaven"
      }
    ]
    remove_headers_config = [
      {
        header = "Access-Control"
      },
      {
        header = "Date"
      },
      {
        header = "User-Agent"
      },
      {
        header = "Age"
      },
    ]
  }
}


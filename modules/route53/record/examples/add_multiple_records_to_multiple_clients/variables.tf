variable "zone_tags" {
  type        = map(string)
  description = "Tags to apply to the zone"
  default = {
    Name        = "TestZoneModule"
    Description = "Test Zone module as a root zone"
  }
}

variable "zones_configuration" {
  description = "Configuration of all DNS zones."
  type = list(object({
    domain_name = string
    apex_zone   = optional(bool, true)
  }))
  default = [
    {
      domain_name = "l8bloom.hr",
    },
    {
      domain_name = "ina.hr",
    },
    {
      domain_name = "merlio.dev",
    },
    {
      domain_name = "pilot.com",
    },
    {
      domain_name = "mecca.it",
    },
    {
      domain_name = "it8.io",
    }
  ]
}

variable "records_configuration" {
  description = "Configuration of all records in all DNS zones."
  type = list(object({
    full_name    = string
    record_owner = string
    name         = string
    type         = string
    records      = list(string)
    ttl          = optional(number, 300)
  }))
  default = [
    {
      full_name    = "l8bloom_hr_txt_@"
      record_owner = "l8bloom.hr"
      name         = ""
      type         = "TXT"
      records      = ["I like orange juice."]
    },
    {
      full_name    = "l8bloom_hr_mx_@"
      record_owner = "l8bloom.hr"
      name         = ""
      type         = "MX"
      records      = ["10 mail.l8bloom.hr"]
    },
    {
      full_name    = "ina_hr_mx_@mail"
      record_owner = "ina.hr"
      name         = "@mail"
      type         = "MX"
      records      = ["10 mail.ina.hr"]
    },
    {
      full_name    = "merlio_dev_txt_pref"
      record_owner = "merlio.dev"
      name         = "pref"
      type         = "TXT"
      records      = ["Orange juice."]
    },
    {
      full_name    = "pilot_com_mx_mail"
      record_owner = "pilot.com"
      name         = "mail.pilot.com"
      type         = "MX"
      records      = ["10 bla-bla"]
    },
    {
      full_name    = "mecca_it_mx_mail"
      record_owner = "mecca.it"
      name         = "mail"
      type         = "MX"
      records      = ["100 mecca_of_all_programming"]
    },
    {
      full_name    = "it8_io_txt_note"
      record_owner = "it8.io"
      name         = ""
      type         = "TXT"
      records      = ["I really like programming.(Me gusta programming.)"]
    }
  ]
}
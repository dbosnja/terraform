# DNS Delegation Set Module

This folder contains a minimal Terraform configuration deployable on AWS and consisting of following resources:

- one delegation set of name servers to be used throughout the domains in an account

## Why this module?

This module can be used when in need for a reusable set of DNS name servers. It deploys a new DNS name servers set in an account and provides 4 name servers distributed throughout 4 different TLDs.  
The overhead of the name servers is about 20ms.  

## Quick Start

The module requires no parameters.  
Outputs of the module are:

- `name_servers` a list of 4 provisioned name servers
- `id` the delegation ID

Example of module's invocation:

> `module my_module {`  
`  source      = "./module"`  
`}`

Check provided examples in *examples* directory for further instructions.

## Tests
The module is accompanied with a set of tests in order to sky rock confidence and robustness :)
The following command runs all tests in the module in a verbose mode.  
> `go test -v`

### Author

Domagoj Bošnjak
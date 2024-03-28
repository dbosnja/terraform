# Elastic IP Address Module

This folder contains a minimal Terraform configuration deployable on AWS and consisting of following resources:

- one public IP address

## Why this module?

This module can be used when in need for a public IP address.

## Quick Start

The module requires no parameters.  
Outputs of the module are:

- `public_ip` public IP address
- `id` its ID

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
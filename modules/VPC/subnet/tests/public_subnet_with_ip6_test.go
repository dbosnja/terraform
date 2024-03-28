package tests

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestPublicSubnetWithIPv6Enabled(t *testing.T) {
	opts := &terraform.Options{
		TerraformDir: "../examples/public_subnet_with_ip6",
	}

	defer terraform.Destroy(t, opts)

	terraform.InitAndApply(t, opts)

	terraform.OutputRequired(t, opts, "public_subnet_id")
	terraform.OutputRequired(t, opts, "cidr_block")
	terraform.OutputRequired(t, opts, "ipv6_cidr_block")
}

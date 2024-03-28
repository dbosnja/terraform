package tests

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestPrivateSubnetWithIPv6Enabled(t *testing.T) {
	opts := &terraform.Options{
		TerraformDir: "../examples/private_subnet_with_ip6",
	}

	defer terraform.Destroy(t, opts)

	terraform.InitAndApply(t, opts)

	terraform.OutputRequired(t, opts, "private_subnet_id")
	terraform.OutputRequired(t, opts, "cidr_block")
}

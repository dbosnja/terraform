package tests

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestVPCWithIP6(t *testing.T) {
	opts := &terraform.Options{
		TerraformDir: "../examples/vpc_with_ip6",
	}

	defer terraform.Destroy(t, opts)

	terraform.InitAndApply(t, opts)

	terraform.OutputRequired(t, opts, "id")
	terraform.OutputRequired(t, opts, "main_route_table_id")
	terraform.OutputRequired(t, opts, "cidr_block")
	terraform.OutputRequired(t, opts, "ipv6_cidr_block")
}

package tests

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestVPCOnlyIP4(t *testing.T) {
	opts := &terraform.Options{
		TerraformDir: "../examples/vpc_ip4_only",
	}

	defer terraform.Destroy(t, opts)

	terraform.InitAndApply(t, opts)

	terraform.OutputRequired(t, opts, "id")
	terraform.OutputRequired(t, opts, "main_route_table_id")
	terraform.OutputRequired(t, opts, "cidr_block")
}

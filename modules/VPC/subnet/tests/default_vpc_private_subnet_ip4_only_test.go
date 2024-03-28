package tests

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestDefaultVPCPrivateSubnetIP4Only(t *testing.T) {
	opts := &terraform.Options{
		TerraformDir: "../examples/default_vpc_private_subnet_ip4_only",
	}

	defer terraform.Destroy(t, opts)

	terraform.InitAndApply(t, opts)

	terraform.OutputRequired(t, opts, "private_subnet_id")
	terraform.OutputRequired(t, opts, "cidr_block")
}

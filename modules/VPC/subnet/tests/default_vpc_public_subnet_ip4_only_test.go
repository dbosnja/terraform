package tests

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestDefaultVPCPublicSubnetIP4Only(t *testing.T) {
	opts := &terraform.Options{
		TerraformDir: "../examples/default_vpc_public_subnet_ip4_only",
	}

	defer terraform.Destroy(t, opts)

	terraform.InitAndApply(t, opts)

	terraform.OutputRequired(t, opts, "public_subnet_id")
	terraform.OutputRequired(t, opts, "cidr_block")
}

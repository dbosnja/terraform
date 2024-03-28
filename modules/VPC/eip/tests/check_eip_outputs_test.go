package test

import (
	"regexp"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestEIPOutputs(t *testing.T) {
	opts := &terraform.Options{
		TerraformDir: "../examples/check_eip_outputs",
	}

	defer terraform.Destroy(t, opts)

	terraform.InitAndApply(t, opts)

	terraform.OutputRequired(t, opts, "id")

	publicIP := terraform.OutputRequired(t, opts, "public_ip")
	assert.Regexp(t, regexp.MustCompile(`\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}`), publicIP, "Public IP does not follow the IP pattern!")
}

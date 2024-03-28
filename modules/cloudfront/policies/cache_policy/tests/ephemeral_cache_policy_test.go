package tests

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestEphemeralCachePolicy(t *testing.T) {
	opts := &terraform.Options{
		TerraformDir: "../examples/ephemeral_cache_policy",
	}

	defer terraform.Destroy(t, opts)

	terraform.InitAndApply(t, opts)

	terraform.OutputRequired(t, opts, "id")
	terraform.OutputRequired(t, opts, "etag")
}

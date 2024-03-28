package tests

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestUserAgentRefererOriginRequestPolicy(t *testing.T) {
	opts := &terraform.Options{
		TerraformDir: "../examples/user_agent_referer_origin_request_policy",
	}

	defer terraform.Destroy(t, opts)

	terraform.InitAndApply(t, opts)

	terraform.OutputRequired(t, opts, "id")
	terraform.OutputRequired(t, opts, "etag")
}

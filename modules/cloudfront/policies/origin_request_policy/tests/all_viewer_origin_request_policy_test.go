package tests

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAllViewerOriginRequestPolicy(t *testing.T) {
	opts := &terraform.Options{
		TerraformDir: "../examples/all_viewer_origin_request_policy",
	}

	defer terraform.Destroy(t, opts)

	terraform.InitAndApply(t, opts)

	terraform.OutputRequired(t, opts, "id")
	terraform.OutputRequired(t, opts, "etag")
}

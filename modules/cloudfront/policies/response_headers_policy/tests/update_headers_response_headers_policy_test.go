package tests

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestUpdateHeadersResponseHeadersPolicy(t *testing.T) {
	opts := &terraform.Options{
		TerraformDir: "../examples/update_headers_response_headers_policy",
	}

	defer terraform.Destroy(t, opts)

	terraform.InitAndApply(t, opts)

	terraform.OutputRequired(t, opts, "id")
	terraform.OutputRequired(t, opts, "etag")
}

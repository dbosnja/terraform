package test

import (
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestAddMultipleRecordsToMultipleClients(t *testing.T) {
	opts := &terraform.Options{
		TerraformDir: "../examples/add_multiple_records_to_multiple_clients",
	}

	defer terraform.Destroy(t, opts)

	terraform.InitAndApply(t, opts)

	fqdn := terraform.OutputRequired(t, opts, "fqdns")
	fqdn = strings.Trim(fqdn, "[]")
	fqdnSlice := strings.SplitAfter(fqdn, " ")
	assert.Equal(t, 7, len(fqdnSlice), "There must be 7 DNS records created.")

	name := terraform.OutputRequired(t, opts, "names")
	name = strings.Trim(name, "[]")
	nameSlice := strings.SplitAfter(name, " ")
	assert.Equal(t, 7, len(nameSlice), "There must be 7 DNS records created.")
}

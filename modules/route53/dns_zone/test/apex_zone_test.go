package test

import (
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestApexZone(t *testing.T) {
	opts := &terraform.Options{
		TerraformDir: "../examples/apex_zone",
	}

	defer terraform.Destroy(t, opts)

	terraform.InitAndApply(t, opts)

	terraform.OutputRequired(t, opts, "zone_id")
	terraform.OutputRequired(t, opts, "name_servers")
	terraform.OutputRequired(t, opts, "primary_name_server")
	terraform.Output(t, opts, "subzone_ns_record_fqdn")
	terraform.Output(t, opts, "subzone_ns_record_name")

	subzone_ns_record_fqdn := terraform.Output(t, opts, "subzone_ns_record_fqdn")
	subzone_ns_record_name := terraform.Output(t, opts, "subzone_ns_record_name")
	assert.Equal(t, "", subzone_ns_record_fqdn)
	assert.Equal(t, "", subzone_ns_record_name)

	nameServers := terraform.OutputRequired(t, opts, "name_servers")
	nameServers = strings.Trim(nameServers, "[]")
	nameServersSlice := strings.SplitAfter(nameServers, " ")
	assert.Equal(t, 4, len(nameServersSlice), "There must be 4 Name servers created.")
}

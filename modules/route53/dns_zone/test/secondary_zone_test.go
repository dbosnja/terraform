package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestSecondaryZone(t *testing.T) {
	opts := &terraform.Options{
		TerraformDir: "../examples/secondary_zone",
	}

	defer terraform.Destroy(t, opts)

	terraform.InitAndApply(t, opts)

	terraform.OutputRequired(t, opts, "zone_id")
	terraform.OutputRequired(t, opts, "sub_zone_id")

	terraform.OutputRequired(t, opts, "name_servers")
	terraform.OutputRequired(t, opts, "subzone_name_servers")

	terraform.OutputRequired(t, opts, "primary_name_server")
	terraform.OutputRequired(t, opts, "subzone_primary_name_server")

	fqdn := terraform.OutputRequired(t, opts, "subzone_ns_record_fqdn")
	recordName := terraform.OutputRequired(t, opts, "subzone_ns_record_name")

	assert.Equal(t, "dev.l8bloom.hr", fqdn)
	assert.Equal(t, "dev.l8bloom.hr", recordName)
}

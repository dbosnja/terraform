package test

import (
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestMultipleClientZones(t *testing.T) {
	opts := &terraform.Options{
		TerraformDir: "../examples/multiple_client_zones",
	}

	defer terraform.Destroy(t, opts)

	terraform.InitAndApply(t, opts)

	clientZones := terraform.OutputRequired(t, opts, "client_zone_ids")
	clientZones = strings.Trim(clientZones, "[]")
	clientZonesSlice := strings.SplitAfter(clientZones, " ")
	assert.Equal(t, 5, len(clientZonesSlice), "There must be 5 client zones created.")

	fqdns := terraform.OutputRequired(t, opts, "client_zone_subzone_ns_record_fqdns")
	fqdns = strings.Trim(fqdns, "[]")
	fqdnsSlice := strings.SplitAfter(fqdns, " ")
	assert.Equal(t, 5, len(fqdnsSlice), "There must be 5 client zones record fqdns created.")

	recordNames := terraform.OutputRequired(t, opts, "client_zone_subzone_ns_record_names")
	recordNames = strings.Trim(recordNames, "[]")
	recordNamesSlice := strings.SplitAfter(recordNames, " ")
	assert.Equal(t, 5, len(recordNamesSlice), "There must be 5 client zones record names created.")
}

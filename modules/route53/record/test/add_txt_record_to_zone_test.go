package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestAddRecordToZone(t *testing.T) {
	opts := &terraform.Options{
		TerraformDir: "../examples/add_txt_record_to_zone",
	}

	defer terraform.Destroy(t, opts)

	terraform.InitAndApply(t, opts)

	name := terraform.Output(t, opts, "name")
	fqdn := terraform.OutputRequired(t, opts, "fqdn")

	assert.Equal(t, name, "", "Wrong TXT Record name.")
	assert.Equal(t, fqdn, "l8bloom.hr", "Wrong TXT Record's FQDN.")
}

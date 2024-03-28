package test

import (
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestDelegationSet(t *testing.T) {
	opts := &terraform.Options{
		TerraformDir: "../examples/check_delegation_set_output",
	}

	defer terraform.Destroy(t, opts)

	terraform.InitAndApply(t, opts)

	terraform.OutputRequired(t, opts, "id")
	nameServers := terraform.OutputRequired(t, opts, "name_servers")

	nameServers = strings.Trim(nameServers, "[]")
	nameServersSlice := strings.SplitAfter(nameServers, " ")
	assert.Equal(t, 4, len(nameServersSlice), "There must be 4 Name servers created.")
}

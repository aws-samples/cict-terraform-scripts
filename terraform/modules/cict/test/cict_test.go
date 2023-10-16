package test

import (
	"fmt"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"strings"
	"testing"
)

func TestCodePipelineCreation(t *testing.T) {

	uniqueId := strings.ToLower(random.UniqueId())
	awsRegion := aws.GetRandomStableRegion(t, nil, nil)
	awsAccountID := aws.GetAccountId(t)
	expectedName := fmt.Sprintf("terratest-aws-example-%s", random.UniqueId())
	expectedTags := map[string]string{
		"Application":    expectedName,
		"Environment":    "Terratest",
		"DeploymentType": "Terratest",
	}

	terraformOptions := &terraform.Options{
		// Set the path to the Terraform code that will be tested.
		TerraformDir: "../",

		// Here provide the values for the terraform variables
		Vars: map[string]interface{}{
			"custom_tags":                     expectedTags,
			"pipeline_deployment_bucket_name": fmt.Sprintf("testing-%s", uniqueId),
			"account_id":                      awsAccountID,
			"region":                          awsRegion,
			"git_repository_name":             "mocked",
			"branches":                        []string{"dev"},
		},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: false,
	}

	// Clean up resources with "terraform destroy" at the end of the test.
	defer terraform.Destroy(t, terraformOptions)

	// Run "terraform init" and "terraform apply". Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	// outputCodePipelineName := terraform.Output(t, terraformOptions, "codepipeline_name")
	// outputCodeBuildProjectName := terraform.Output(t, terraformOptions, "codebuild_name")

	// Run `terraform output` to get the values of output variables and check they have the expected values.
	actualTags := terraform.OutputMap(t, terraformOptions, "custom_tags")

	// Verify we're getting back the outputs we expect
	// assert.Equal(t, "[mocked-dev]", outputCodePipelineName)
	// assert.Equal(t, "[mocked-build]", outputCodeBuildProjectName)
	assert.Equal(t, expectedTags, actualTags)
}

func TestDefaultTags(t *testing.T) {

	uniqueId := strings.ToLower(random.UniqueId())
	awsRegion := aws.GetRandomStableRegion(t, nil, nil)
	awsAccountID := aws.GetAccountId(t)
	expectedName := fmt.Sprintf("terratest-aws-example-%s", random.UniqueId())
	expectedTags := map[string]string{
		"Application":    expectedName,
		"Environment":    "Terratest",
		"DeploymentType": "Terratest",
	}

	terraformOptions := &terraform.Options{
		// Set the path to the Terraform code that will be tested.
		TerraformDir: "../",

		// Here provide the values for the terraform variables
		Vars: map[string]interface{}{
			"custom_tags":                     expectedTags,
			"pipeline_deployment_bucket_name": fmt.Sprintf("testing-%s", uniqueId),
			"account_id":                      awsAccountID,
			"region":                          awsRegion,
			"git_repository_name":             "mocked",
			"branches":                        []string{"dev"},
		},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: false,
	}

	// Clean up resources with "terraform destroy" at the end of the test.
	defer terraform.Destroy(t, terraformOptions)

	// Run "terraform init" and "terraform apply". Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the values of output variables and check they have the expected values.
	actualTags := terraform.OutputMap(t, terraformOptions, "custom_tags")

	// Verify we're getting back the outputs we expect
	assert.Equal(t, expectedTags, actualTags)

	// Positive Scenario when the matched tag is  found in the expected output
	assert.Contains(t, actualTags, "Application", "Application tag was found in the output")

	// Negative Scenario when the given tag is not present in the expected output
	// assert.Contains(t, actualTags, "CostCentre", "CostCentre tag was not found in the output ")
}
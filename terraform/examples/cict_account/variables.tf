variable "custom_tags" {
  description = "AWS Resource tags"
  type = object({
    Environment    = string
    DeploymentType = string
    Application    = string
  })
  default = {
    Environment    = "Deployment"
    DeploymentType = "Terraform"
    Application    = "testapp"
  }
}

variable "account_id" {
  description = "Account ID where resources will be deployed"
  type        = string
  default     = ""
}

variable "git_repository_name" {
  description = "Name of the remote git repository to be created"
  type        = string
  default     = "cict-terraform"
}

variable "code_pipeline_build_stages" {
  description = "Maps of build type stages configured in CodePipeline"
  default = {
    "validate"  = "terraform/modules/buildspec-tfvalidate.yaml",
    "tflint"    = "terraform/modules/buildspec-tflint.yaml",
    "checkov"   = "terraform/modules/buildspec-checkov.yaml",
    "terratest" = "terraform/modules/buildspec-terratest.yaml"
  }
}

variable "region" {
  description = "AWS region where all the resources will be deployed"
  default     = "eu-west-2"
  type        = string
}
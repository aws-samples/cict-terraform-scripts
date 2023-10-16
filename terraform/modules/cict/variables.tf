variable "custom_tags" {
  description = "Resources tags"
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

variable "git_repository_name" {
  description = "Name of the remote git repository to be created"
  default = "codecommit-default"
  type        = string
}

variable "code_pipeline_build_stages" {
  description = "maps of build type stages configured in CodePipeline"
  default = {
    "validate" = "terraform/modules/buildspec-tfvalidate.yaml",
    "tflint" = "terraform/modules/buildspec-tflint.yaml",
    "checkov" = "terraform/modules/buildspec-checkov.yaml",
    "terratest" = "terraform/modules/buildspec-terratest.yaml"
  }
}

variable "region" {
  description = "AWS region where the resources will be deployed"
  default     = "eu-west-2"
  type        = string
}

variable "account_id" {
  description = "Account ID where resources will be deployed"
  type        = string
  default     = ""
}

variable "priv_vpc_config" {
  description = "Map of values for private VPC, subnet_ids and security_group_ids are comma separated lists"
  type = object({
    vpc_id             = string
    subnet_ids         = string
    security_group_ids = string
  })
  default = {
    vpc_id             = ""
    subnet_ids         = ""
    security_group_ids = ""
  }
}

variable "roles" {
  description = "Roles ARN used to deploy, in case of cross account deployments these roles should thrust the CIDE account"
  type        = list(any)
  default     = []
}

variable "proxy_config" {
  description = "Proxies used by CodeBuild"
  type = object({
    HTTP_PROXY  = string
    HTTPS_PROXY = string
    NO_PROXY    = string
    no_proxy    = string
    https_proxy = string
    http_proxy  = string
  })
  default = {
    HTTP_PROXY  = ""
    HTTPS_PROXY = ""
    no_proxy    = ""
    https_proxy = ""
    http_proxy  = ""
    NO_PROXY    = ""
  }
}


variable "branches" {
  description = "Branches to be built"
  type        = list(string)
  default     = ["cleanup"]
}


variable "pipeline_deployment_bucket_name" {
  description = "Bucket used by codepipeline and codebuild to store artifacts regarding the deployment"
  type        = string
  default     = "testrandom"
}

variable "codebuild_image" {
  description = "Describe the AWS CodeBuild Image"
  type = string
  default = "aws/codebuild/standard:5.0"
}
plugin "aws" {
    enabled = true
    version = "0.18.0"
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

rule "aws_resource_missing_tags" {
  enabled = true
  tags = ["Environment", "Application" , "DeploymentType", "Food"]
  exclude = ["aws_autoscaling_group","aws_iam_role"] # (Optional) Exclude some resource types from tag checks
}

rule "aws_s3_bucket_name" {
  enabled = true
  regex = "^[a-z\\-]+$"
  prefix = "test"
}

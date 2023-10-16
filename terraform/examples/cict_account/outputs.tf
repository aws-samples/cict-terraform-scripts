output "AWS_Region" {
  description = "Region  where the AWS resources will be deployed"
  value       = module.setup_testing_pipeline.region
}

output "CodePipeline_S3_bucket" {
  description = "S3 bucket storing CodePipeline artefacts"
  value       = module.setup_testing_pipeline.codepipeline_s3_bucket
}

output "CodeBuild_S3_bucket" {
  description = "S3 bucket storing CodeBuild artefacts"
  value       = module.setup_testing_pipeline.codebuild_s3_bucket
}

output "CodePipeline_Name" {
  description = "Name of the CodePipeline"
  value       = module.setup_testing_pipeline.codepipeline_name[0]
}

output "CodeCommit_Repository_Name" {
  description = "CodeCommit Repository Name"
  value       = module.setup_testing_pipeline.codecommit_repo_name
}

output "AWS_Resource_Tags" {
  description = "AWS Resource Tags to be applied"
  value       = module.setup_testing_pipeline.custom_tags
}
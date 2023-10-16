output "codepipeline_name" {
  value = values(aws_codepipeline.awscodepipeline)[*].id
}

output "codebuild_name" {
  value = values(aws_codebuild_project.awscodebuild_project)[*].name
}

output "codepipeline_s3_bucket" {
  value = aws_s3_bucket.awscodepipeline_s3_bucket.bucket
}

output "codebuild_s3_bucket" {
  value = aws_s3_bucket.awscodebuild_bucket.bucket
}

output "codecommit_repo_name" {
  value = aws_codecommit_repository.awscodecommit_repo.repository_name
}

output "custom_tags" {
  value = aws_codecommit_repository.awscodecommit_repo.tags
}

output "region" {
  value = data.aws_region.current.name
}
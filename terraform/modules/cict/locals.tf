locals {
  buckets_to_lock = {
    codepipeline = aws_s3_bucket.awscodepipeline_s3_bucket.id
    codebuild    = aws_s3_bucket.awscodebuild_bucket.id
  }
}
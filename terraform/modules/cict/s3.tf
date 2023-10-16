#### Create Amazon S3 Codepipeline artefacts bucket ####

resource "aws_s3_bucket" "awscodepipeline_s3_bucket" {
  bucket = "${var.pipeline_deployment_bucket_name}-${data.aws_region.current.name}-codepipeline"
  acl    = "private"
  #checkov:skip=CKV2_AWS_6
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }

  # Neede for CloudWatch
  versioning {
    enabled = true
  }

  tags = var.custom_tags
}


#### Create Amazon S3 bucket for Codebuild project ####

resource "aws_s3_bucket" "awscodebuild_bucket" {
  bucket = "${var.pipeline_deployment_bucket_name}-${data.aws_region.current.name}-codebuild"
  acl    = "private"
  #checkov:skip=CKV2_AWS_6
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }

  tags = var.custom_tags
}

resource "aws_s3_bucket_public_access_block" "pipeline_buckets" {

  for_each                = local.buckets_to_lock
  bucket                  = each.value
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
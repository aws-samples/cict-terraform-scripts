#### Create a CODEBUILD Project #####

resource "random_pet" "rname" {
}

resource "aws_codebuild_project" "awscodebuild_project" {
  for_each      = var.code_pipeline_build_stages
  name          = "${random_pet.rname.id}-${each.key}-cb-project"
  description   = "Code build project for ${var.git_repository_name} ${each.key} stage"
  build_timeout = "120"
  service_role  = aws_iam_role.awscodebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE"]
  }

  environment {
    image                       = var.codebuild_image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    compute_type                = "BUILD_GENERAL1_SMALL"

    dynamic "environment_variable" {
      for_each = var.proxy_config["HTTP_PROXY"] != "" ? var.proxy_config : {}
      content {
        name  = environment_variable.key
        value = environment_variable.value
      }
    }
  }

 
  dynamic "vpc_config" {
    for_each = var.priv_vpc_config["vpc_id"] != "" ? [var.priv_vpc_config["vpc_id"]] : []
    content {
      vpc_id             = var.priv_vpc_config["vpc_id"]
      subnets            = split(",", var.priv_vpc_config["subnet_ids"])
      security_group_ids = split(",", var.priv_vpc_config["security_group_ids"])
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.awscodebuild_bucket.id}/${each.key}/build_logs"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = each.value
  }

  tags = var.custom_tags

}
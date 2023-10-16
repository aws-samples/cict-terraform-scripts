#### Create IAM Cross-account Role and Policy for Codebuild projects ####

resource "aws_iam_role" "awscodebuild_role" {
  name = "codebuild-${var.git_repository_name}-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "awscodebuild_policy" {
  name = "codebuild-${var.git_repository_name}-policy"
  role = aws_iam_role.awscodebuild_role.name

  policy = templatefile("${path.module}/templates/codebuild-role_policy.json.tpl",
    {
      codepipeline_artifact_bucket = aws_s3_bucket.awscodepipeline_s3_bucket.arn
      priv_vpc_id                  = var.priv_vpc_config["vpc_id"]
      account_id                   = data.aws_caller_identity.current.account_id
  })
}

#### Create IAM role and policies for CodePipeline ####

resource "aws_iam_role" "awscodepipeline_role" {
  name = "codepipeline-${random_pet.rname.id}-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "awscodepipeline_policy" {
  name = "codepipeline-${random_pet.rname.id}-policy"
  role = aws_iam_role.awscodepipeline_role.id

  policy = templatefile("${path.module}/templates/codepipeline-role-policy.json.tpl", {
    codepipeline_bucket_arn = aws_s3_bucket.awscodepipeline_s3_bucket.arn
  })
}
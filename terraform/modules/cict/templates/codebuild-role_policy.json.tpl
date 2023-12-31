{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "codepipeline:DeleteWebhook",
        "codecommit:TagResource",
        "iam:PutRolePolicy",
        "codecommit:ListTagsForResource",
        "s3:DeleteJobTagging",
        "s3:PutObjectTagging",
        "iam:ListRolePolicies",
        "s3:DeleteObject",
        "iam:GetRole",
        "codepipeline:ListWebhooks",
        "s3:PutAccountPublicAccessBlock",
        "s3:GetBucketWebsite",
        "s3:DeleteStorageLensConfigurationTagging",
        "s3:GetMultiRegionAccessPoint",
        "s3:GetObjectAttributes",
        "iam:DeleteRole",
        "s3:DeleteObjectVersionTagging",
        "s3:GetObjectLegalHold",
        "s3:GetBucketNotification",
        "s3:DescribeMultiRegionAccessPointOperation",
        "s3:GetReplicationConfiguration",
        "s3:PutObject",
        "s3:PutObjectVersionAcl",
        "s3:PutAccessPointPublicAccessBlock",
        "iam:GetRolePolicy",
        "codebuild:PersistOAuthToken",
        "s3:GetStorageLensDashboard",
        "s3:GetLifecycleConfiguration",
        "s3:GetInventoryConfiguration",
        "s3:GetBucketTagging",
        "codepipeline:CreatePipeline",
        "s3:GetAccessPointPolicyForObjectLambda",
        "s3:ReplicateTags",
        "codecommit:CreateRepository",
        "s3:ListBucket",
        "iam:ListInstanceProfilesForRole",
        "iam:PassRole",
        "s3:AbortMultipartUpload",
        "s3:PutBucketTagging",
        "iam:DeleteRolePolicy",
        "codebuild:ImportSourceCredentials",
        "s3:DeleteBucket",
        "s3:PutBucketVersioning",
        "s3:GetMultiRegionAccessPointPolicyStatus",
        "s3:PutStorageLensConfigurationTagging",
        "s3:PutObjectVersionTagging",
        "s3:GetBucketVersioning",
        "s3:GetAccessPointConfigurationForObjectLambda",
        "codepipeline:DeleteCustomActionType",
        "s3:GetStorageLensConfiguration",
        "s3:GetAccountPublicAccessBlock",
        "s3:GetBucketCORS",
        "codebuild:DeleteProject",
        "codepipeline:GetPipelineExecution",
        "s3:GetObjectVersion",
        "codepipeline:ListPipelineExecutions",
        "s3:GetObjectVersionTagging",
        "iam:CreateRole",
        "s3:CreateBucket",
        "iam:AttachRolePolicy",
        "codepipeline:ListTagsForResource",
        "s3:GetStorageLensConfigurationTagging",
        "s3:GetObjectAcl",
        "s3:GetBucketObjectLockConfiguration",
        "logs:CreateLogStream",
        "iam:DetachRolePolicy",
        "s3:GetIntelligentTieringConfiguration",
        "iam:ListAttachedRolePolicies",
        "codepipeline:ListPipelines",
        "codepipeline:GetPipeline",
        "s3:GetObjectVersionAcl",
        "s3:DeleteObjectTagging",
        "s3:GetBucketPolicyStatus",
        "s3:GetObjectRetention",
        "s3:GetJobTagging",
        "logs:CreateLogGroup",
        "codepipeline:GetJobDetails",
        "codebuild:CreateProject",
        "s3:GetObject",
        "codecommit:GetRepository",
        "s3:DescribeJob",
        "codepipeline:UntagResource",
        "s3:GetAnalyticsConfiguration",
        "codebuild:DeleteOAuthToken",
        "s3:GetObjectVersionForReplication",
        "s3:GetAccessPointForObjectLambda",
        "s3:GetAccessPoint",
        "s3:DeleteObjectVersion",
        "s3:GetBucketLogging",
        "s3:ListBucketVersions",
        "s3:GetAccelerateConfiguration",
        "codepipeline:DeletePipeline",
        "s3:GetObjectVersionAttributes",
        "s3:GetBucketPolicy",
        "s3:PutEncryptionConfiguration",
        "codepipeline:TagResource",
        "s3:GetEncryptionConfiguration",
        "s3:GetObjectVersionTorrent",
        "s3:GetBucketRequestPayment",
        "s3:GetAccessPointPolicyStatus",
        "s3:GetObjectTagging",
        "s3:GetMetricsConfiguration",
        "s3:GetBucketOwnershipControls",
        "codebuild:BatchGetProjects",
        "s3:GetBucketPublicAccessBlock",
        "s3:PutBucketPublicAccessBlock",
        "s3:GetMultiRegionAccessPointPolicy",
        "s3:GetAccessPointPolicyStatusForObjectLambda",
        "s3:PutJobTagging",
        "codecommit:DeleteRepository",
        "s3:GetBucketAcl",
        "logs:PutLogEvents",
        "s3:GetObjectTorrent",
        "codebuild:DeleteSourceCredentials",
        "s3:GetBucketLocation",
        "s3:GetAccessPointPolicy"
      ]
    },
    {
      "Effect": "Allow",
      "Resource": [
        "arn:aws:codebuild:eu-west-2:${account_id}:report-group/*"
      ],
      "Action": [
        "codebuild:DeleteBuildBatch",
        "codebuild:DeleteWebhook",
        "codebuild:InvalidateProjectCache",
        "codebuild:RetryBuildBatch",
        "codebuild:UpdateProjectVisibility",
        "codebuild:StopBuild",
        "codebuild:DeleteReportGroup",
        "codebuild:UpdateWebhook",
        "codebuild:CreateWebhook",
        "codebuild:RetryBuild",
        "codebuild:CreateProject",
        "codebuild:UpdateProject",
        "codebuild:StopBuildBatch",
        "codebuild:UpdateReportGroup",
        "codebuild:CreateReportGroup",
        "codebuild:CreateReport",
        "codebuild:UpdateReport",
        "codebuild:StartBuildBatch",
        "codebuild:DeleteReport",
        "codebuild:BatchPutCodeCoverages",
        "codebuild:BatchDeleteBuilds",
        "codebuild:DeleteProject",
        "codebuild:StartBuild",
        "codebuild:BatchPutTestCases"
      ]
    },
%{ if priv_vpc_id != "" }
    {
      "Effect": "Allow", 
      "Action": [
        "ec2:AssociateIamInstanceProfile"
      ],
      "Resource": "*" 
    },
%{ endif }
    {
      "Effect": "Allow",
      "Resource": [
        "${codepipeline_artifact_bucket}",
        "${codepipeline_artifact_bucket}/*"
      ],
      "Action": [
        "s3:PutObject"
      ]
    }
  ]
}
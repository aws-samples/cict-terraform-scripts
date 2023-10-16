#### Create CODECOMMIT REPOSITORY ####

resource "aws_codecommit_repository" "awscodecommit_repo" {
  repository_name = var.git_repository_name
  description     = "Code Repository For CICT CODEPIPELINE PROJECT"

  tags = var.custom_tags
}
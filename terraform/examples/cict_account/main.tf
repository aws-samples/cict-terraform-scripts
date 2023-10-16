locals {
  region     = var.region != "" ? var.region : data.aws_region.current.name
  account_id = var.account_id != "" ? var.account_id : data.aws_caller_identity.current.account_id
}

module "setup_testing_pipeline" {
  source                          = "../../modules/cict"
  custom_tags                     = var.custom_tags
  pipeline_deployment_bucket_name = "${var.git_repository_name}-${local.account_id}"
  account_id                      = local.account_id
  region                          = local.region
  code_pipeline_build_stages      = var.code_pipeline_build_stages
  git_repository_name             = var.git_repository_name
}
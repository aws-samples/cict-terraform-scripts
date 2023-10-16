terraform {
  required_providers {
    aws = {
      version = "~> 3.63.0"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      Application = "test"
    }
  }
  region = var.region
}

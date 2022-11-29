provider "aws" {
  profile = "eq-lab"
  region  = "eu-central-1"
}

terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    encrypt = true
  }
}

module "s3_module" {
  source = "./modules/s3"

  bucket_codepipeline = "${local.project_id}-codepipeline"
  bucket_codebuild = "${local.project_id}-codebuild"
  bucket_codecommit = "${local.project_id}-codecommit"
  bucket_codeartifact = "${local.project_id}-codeartifact"

  region = var.terraform_bucket.region
  bootstrap_bucket = var.terraform_bucket.bootstrap_bucket
  bootstrap_bucket_key = var.terraform_bucket.bootstrap_bucket_key

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

module "codepipeline_module" {
  source = "./modules/codepipeline"

  codepipeline_bucket = module.s3_module.codepipeline-bucket-name
  codepipeline_bucket_arn = module.s3_module.codepipeline-bucket-arn

  region = var.terraform_bucket.region
  bootstrap_bucket = var.terraform_bucket.bootstrap_bucket
  bootstrap_bucket_key = var.terraform_bucket.bootstrap_bucket_key

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}
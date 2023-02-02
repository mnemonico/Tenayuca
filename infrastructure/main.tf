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
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
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

  cicd_project_name = var.cicd_project_name
  codebuild_projects = var.build_projects
  repo_branch = var.source_repo_branch
  repo_name = var.source_repo_name
  stages = var.stage_input

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

module "codebuild_module" {
  source = "./modules/codebuild"

  codebuild_bucket = module.s3_module.codebuild-bucket-name
  codebuild_bucket_arn = module.s3_module.codebuild-bucket-arn
  codepipeline_bucket_arn = module.s3_module.codepipeline-bucket-arn


  region = var.terraform_bucket.region
  bootstrap_bucket = var.terraform_bucket.bootstrap_bucket
  bootstrap_bucket_key = var.terraform_bucket.bootstrap_bucket_key

  cicd_project_name = var.cicd_project_name
  codebuild_projects = var.build_projects
  codebuild_project_source = var.build_project_source
  codebuild_compute_type = var.build_compute_type
  codebuild_image = var.build_image
  codebuild_image_pull_credentials_type = var.build_image_pull_credentials_type
  codebuild_type = var.build_type

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }

}

module "kms_module" {
  source = "./modules/kms"

  kms_codeartifact = "kms-codeartifact"

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

module "codeartifact_module" {
  source = "./modules/codeartifact"

  codeartifact_key = module.kms_module.kms-codeartifact-arn
  codeartifact_domain = "vanilla"
  codeartifact_repo = "vanilla-repo"

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}
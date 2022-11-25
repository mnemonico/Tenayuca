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
#    bucket  = local.bootstrap_bucket #"lab-simulation-terraform" # Reference bucket for terraform state
#    key     = local.bootstrap_bucket_key #"infrastructure/terraform.tfstate"
#    region  = "eu-central-1"
    encrypt = true
  }
}

data "terraform_remote_state" "terraform" {
  backend = "s3"

  config = {
    bucket  = var.terraform_bucket.bootstrap_bucket # Reference bucket for terraform state
    key     = var.terraform_bucket.bootstrap_bucket_key
    region  = "eu-central-1"
  }
}

#module "codepipeline_s3_bucket" {
#  source = "./modules/codepipeline"
#
#  bucket_name = "${local.project_id}-codepipeline"
#  bootstrap_bucket = var.bootstrap_bucket
#  bootstrap_bucket_key = var.bootstrap_bucket_key
#
#  tags = {
#    Terraform   = "true"
#    Environment = var.environment
#  }
#}
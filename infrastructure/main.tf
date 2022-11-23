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
    bucket  = "lab-simulation-terraform" # Reference bucket for terraform state
    key     = "infrastructure/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }
}

module "codepipeline_s3_bucket" {
  source = "./modules/codepipeline"

  bucket_name = "${local.project_id}-codepipeline"

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}
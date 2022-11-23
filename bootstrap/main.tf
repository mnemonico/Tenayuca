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
    key     = "bootstrap/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }
}

provider "aws" {
  profile = "eq-lab"
  region  = "eu-central-1"
}


resource "aws_kms_key" "s3" {
  description             = "KMS key for S3 buckets"
  key_usage               = "ENCRYPT_DECRYPT"
  deletion_window_in_days = 10
  is_enabled              = true
  enable_key_rotation     = true

  tags  = {
    Customer  = local.Customer
    Provision = local.Provision
    Project = local.project_name
    Name      = "kms-s3"
    Billing   = "No"
  }
}

resource "aws_kms_alias" "s3" {
  name          = "alias/kms-s3"
  target_key_id = aws_kms_key.s3.key_id
}

resource "aws_s3_bucket" "terraform" {
  bucket = "lab-simulation-terraform"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Provision = local.Provision
    Billing   = "No"
    Customer  = local.Customer
    Project = local.project_name
  }
}

resource "aws_s3_bucket_public_access_block" "terraform" {
  bucket = aws_s3_bucket.terraform.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "terraform_bucket_acl" {
  bucket = aws_s3_bucket.terraform.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "terraform_bucket_versioning" {
  bucket = aws_s3_bucket.terraform.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_server_side_encryption_configuration" {
  bucket = aws_s3_bucket.terraform.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.s3.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

locals{
  project_id            = "lab-simulation-v1"
  project_name          = "Lab Simulation Terraform"
  Customer              = "N/A"
  Provision             = "Terraform"

  common_tags = {
    Project   = local.project_name
    Customer  = "N/A"
    Provision = "Terraform"
  }
}

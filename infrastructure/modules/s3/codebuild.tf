resource "aws_s3_bucket" "s3_bucket_codebuild" {
  bucket = var.bucket_codebuild
  tags = var.tags
}

resource "aws_s3_bucket_public_access_block" "codebuild" {
  bucket = aws_s3_bucket.s3_bucket_codebuild.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "codebuild_bucket_acl" {
  bucket = aws_s3_bucket.s3_bucket_codebuild.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "codebuild_bucket_versioning" {
  bucket = aws_s3_bucket.s3_bucket_codebuild.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "server_side_encryption_configuration_codebuild" {
  bucket = aws_s3_bucket.s3_bucket_codebuild.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = data.terraform_remote_state.terraform.outputs.kms-s3
      sse_algorithm     = "aws:kms"
    }
  }
}
resource "aws_s3_bucket" "s3_bucket_codepipeline" {
  bucket = var.bucket_codepipeline
  tags = var.tags
}

resource "aws_s3_bucket_public_access_block" "codepipeline" {
  bucket = aws_s3_bucket.s3_bucket_codepipeline.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "codepipeline_bucket_acl" {
  bucket = aws_s3_bucket.s3_bucket_codepipeline.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "codepipeline_bucket_versioning" {
  bucket = aws_s3_bucket.s3_bucket_codepipeline.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "server_side_encryption_configuration_codepipeline" {
  bucket = aws_s3_bucket.s3_bucket_codepipeline.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = data.terraform_remote_state.terraform.outputs.kms-s3
      sse_algorithm     = "aws:kms"
    }
  }
}
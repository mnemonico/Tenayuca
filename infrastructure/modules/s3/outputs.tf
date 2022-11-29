output "codepipeline-bucket-arn" {
  description = "ARN of the bucket code pipeline"
  value       = aws_s3_bucket.s3_bucket_codepipeline.arn
}

output "codepipeline-bucket-name" {
  description = "Name (id) of the bucket code pipeline"
  value       = aws_s3_bucket.s3_bucket_codepipeline.id
}

output "codebuild-bucket-arn" {
  description = "ARN of the bucket code build"
  value       = aws_s3_bucket.s3_bucket_codebuild.arn
}

output "codebuild-bucket-name" {
  description = "Name (id) of the bucket code build"
  value       = aws_s3_bucket.s3_bucket_codebuild.id
}
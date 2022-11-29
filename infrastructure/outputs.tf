output "codepipeline-bucket-arn" {
  description = "ARN of the bucket code pipeline"
  value       = module.s3_module.codepipeline-bucket-arn
}

output "codepipeline-bucket-name" {
  description = "Name (id) of the bucket code pipeline"
  value       =  module.s3_module.codepipeline-bucket-name
}

output "codepipeline-iam-role" {
  description = "Iam role of code pipeline resource"
  value       =  module.codepipeline_module.iam
}

output "codepipeline-name" {
  description = "Code pipeline resource name"
  value       =  module.codepipeline_module.name
}

output "codepipeline-id" {
  description = "Code pipeline resource name"
  value       =  module.codepipeline_module.id
}

output "codebuild-bucket-arn" {
  description = "ARN of the bucket code build"
  value       = module.s3_module.codebuild-bucket-arn
}

output "codebuild-bucket-name" {
  description = "Name (id) of the bucket code build"
  value       = module.s3_module.codebuild-bucket-name
}
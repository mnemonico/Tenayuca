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


output "kms-codeartifact-name" {
  description = "CodeArtifact KMS resource name"
  value       =  module.kms_module.kms-codeartifact-name
}

output "kms-codeartifact-arn" {
  description = "CodeArtifact KMS resource arn"
  value       =  module.kms_module.kms-codeartifact-arn
}

output "kmsalias-codeartifact-name" {
  description = "CodeArtifact KMS alias resource name"
  value       =  module.kms_module.kmsalias-codeartifact-name
}

output "kmsalias-codeartifact-arn" {
  description = "CodeArtifact KMS alias resource arn"
  value       =  module.kms_module.kmsalias-codeartifact-arn
}

output "codeartifact-domain" {
  description = ""
  value = module.codeartifact_module.codeartifact-domain
}

output "codeartifact-domain-id" {
  description = ""
  value = module.codeartifact_module.codeartifact-domain-id
}

output "codeartifact-domain-arn" {
  description = ""
  value = module.codeartifact_module.codeartifact-domain-arn
}

output "codeartifact-repository-id" {
  description = ""
  value = module.codeartifact_module.codeartifact-repository-id
}

output "codeartifact-repository-arn" {
  description = ""
  value = module.codeartifact_module.codeartifact-repository-arn
}
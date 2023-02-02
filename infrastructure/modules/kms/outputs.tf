output "kms-codeartifact-arn" {
  description = "ARN of the codeartifact kms key"
  value       = aws_kms_key.codeartifact.arn
}

output "kms-codeartifact-name" {
  description = "Name (id) of the codeartifact kms key"
  value       = aws_kms_key.codeartifact.id
}

output "kmsalias-codeartifact-arn" {
  description = "ARN of the codeartifact kms alias"
  value       =  aws_kms_alias.codeartifact.arn
}

output "kmsalias-codeartifact-name" {
  description = "Name (id) of the codeartifact kms alias"
  value       = aws_kms_alias.codeartifact.id
}
output "codeartifact-domain" {
  description = ""
  value = aws_codeartifact_domain.code_artifact_domain.domain
}

output "codeartifact-domain-id" {
  description = ""
  value = aws_codeartifact_domain.code_artifact_domain.id
}

output "codeartifact-domain-arn" {
  description = ""
  value = aws_codeartifact_domain.code_artifact_domain.arn
}

output "codeartifact-repository-id" {
  description = ""
  value = aws_codeartifact_repository.simulation_repository.id
}

output "codeartifact-repository-arn" {
  description = ""
  value = aws_codeartifact_repository.simulation_repository.arn
}
output "id" {
  description = "ARN of the code pipeline resource"
  value       = aws_codepipeline.codepipeline.id
}

output "name" {
  description = "ARN of the code pipeline resource"
  value       = aws_codepipeline.codepipeline.name
}

output "iam" {
  description = "ARN of the code pipeline resource"
  value       = aws_iam_role.codepipeline_role.arn
}
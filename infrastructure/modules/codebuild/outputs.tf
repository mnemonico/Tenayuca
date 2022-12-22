output "id" {
  value       = aws_codebuild_project.codebuild_project_terraform_plan[*].id
  description = "List of IDs of the CodeBuild projects"
}

output "name" {
  value       = aws_codebuild_project.codebuild_project_terraform_plan[*].name
  description = "List of Names of the CodeBuild projects"
}

output "arn" {
  value       = aws_codebuild_project.codebuild_project_terraform_plan[*].arn
  description = "List of ARNs of the CodeBuild projects"
}
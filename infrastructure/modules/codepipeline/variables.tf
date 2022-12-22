variable "bootstrap_bucket" {
  description = "Name of the Terraform bootstrap s3 bucket."
  type        = string
}

variable "bootstrap_bucket_key" {
  description = "Name of the Terraform bootstrap s3 bucket key."
  type        = string
}

variable "region" {
  description = "Terraform bucket region."
  type        = string
}

variable "codepipeline_bucket" {
  description = "Name of the code pipeline s3 bucket."
  type        = string
}

variable "codepipeline_bucket_arn" {
  description = "Name of the code pipeline s3 bucket."
  type        = string
}

variable "codepipeline_project_name" {
  description = "CodePipeline project name"
  type = string
}

variable "repo_name" {
  description = "name of the repository"
  type = string
}

variable "repo_branch" {
  description = "name of the branch"
  type = string
}

variable "stages" {
  description = "List of Map containing information about the stages of the CodePipeline"
  type        = list(map(any))
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}
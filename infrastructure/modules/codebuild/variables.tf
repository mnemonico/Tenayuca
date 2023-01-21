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

variable "codebuild_bucket" {
  description = "Name of the code pipeline s3 bucket."
  type        = string
}

variable "codebuild_bucket_arn" {
  description = "Name of the code pipeline s3 bucket."
  type        = string
}

variable "codepipeline_bucket_arn" {
  description = "Name of the code pipeline s3 bucket."
  type        = string
}

variable "cicd_project_name" {
  description = "CodePipeline project name"
  type = string
}

variable "codebuild_projects" {
  description = "Terraform bucket region."
  type        = list(string)
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}

variable "codebuild_project_source"{
  description = ""
  type = string
}

variable "codebuild_compute_type"{
  description = ""
  type = string
}

variable "codebuild_image"{
  description = ""
  type = string
}

variable "codebuild_image_pull_credentials_type"{
  description = ""
  type = string
}

variable "codebuild_type"{
  description = ""
  type = string
}
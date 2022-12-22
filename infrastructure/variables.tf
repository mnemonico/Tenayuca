variable "environment" {
  description = "Environment"
  type = string
  nullable = false
}

variable "project" {
  description = "project"
  type = object({
    project_id    = string
    project_name = string
    customer = string
    provision = string
  })
  sensitive = false
  nullable = true
  default = {
    project_id = null
    project_name = null
    customer = null
    provision = null
  }
}

variable "terraform_bucket" {
  description = <<-EOT
    Bootstrap Terraform S3 Bucket Name and Keys for Bootstrap and Infra.
    bootstrap_bucket : Bootstrap Bucket name
    bootstrap_bucket_key : file or path or key prefix path to the bootstrap terraform state file
    infrastructure_bucket_key : file or path or key prefix path to the infrastructure terraform state file
    EOT
  type = object({
    bootstrap_bucket    = string
    bootstrap_bucket_key = string
    infrastructure_bucket_key = string
    region = string
  })
  sensitive = true
  nullable = true
  default = {
            bootstrap_bucket  = null
            bootstrap_bucket_key = null
            infrastructure_bucket_key = null
            region = null
    }
  validation {
    condition     = endswith(trimspace(var.terraform_bucket.bootstrap_bucket), "terraform")
    error_message = "the term 'terraform' should be in the bucket name and bootstrap in the key"
  }
  validation {
    condition     = contains(split("/", trimspace(var.terraform_bucket.bootstrap_bucket_key)), "bootstrap")
    error_message = "the term 'bootstrap' in the key"
  }
  validation {
    condition     = contains(split("/", trimspace(var.terraform_bucket.infrastructure_bucket_key)), "infrastructure")
    error_message = "the term 'infrastructure' should be in the key"
  }
}

variable "source_repo_name" {
  description = "Repository name"
  type = string
  nullable = false
}

variable "source_repo_branch" {
  description = "Repository branch"
  type = string
  nullable = false
}

variable "codepipeline_project_name" {
  description = "CodePipeline project name"
  type = string
  nullable = false
}

variable "stage_input" {
  description = "Tags to be attached to the CodePipeline"
  type        = list(map(any))
}

variable "codebuild_project_name" {
  description = "CodeBuild project name"
  type = string
  nullable = false
}

variable "build_projects" {
  description = "List of Names of the CodeBuild projects to be created"
  type        = list(string)
}

variable "build_compute_type" {
  description = "Relative path to the Apply and Destroy build spec file"
  type        = string
  default     = "BUILD_GENERAL1_SMALL"
}

variable "build_image" {
  description = "Docker Image to be used by codebuild"
  type        = string
  default     = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
}

variable "build_type" {
  description = "Type of codebuild run environment"
  type        = string
  default     = "LINUX_CONTAINER"
}

variable "build_image_pull_credentials_type" {
  description = "Image pull credentials type used by codebuild project"
  type        = string
  default     = "CODEBUILD"
}

variable "build_project_source" {
  description = "aws/codebuild/standard:4.0"
  type        = string
  default     = "CODEPIPELINE"
}
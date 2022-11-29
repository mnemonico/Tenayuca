variable "bucket_codepipeline" {
  description = "Name of the Code Pipeline s3 bucket. Must be unique."
  type        = string
}

variable "bucket_codebuild" {
  description = "Name of the Code Build s3 bucket. Must be unique."
  type        = string
}

variable "bucket_codecommit" {
  description = "Name of the Code Commit s3 bucket. Must be unique."
  type        = string
}

variable "bucket_codeartifact" {
  description = "Name of the Code Artifact s3 bucket. Must be unique."
  type        = string
}

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

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}
variable "bucket_name" {
  description = "Name of the s3 bucket. Must be unique."
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

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}
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
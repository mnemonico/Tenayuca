variable "kms_codeartifact" {
  description = "Name of the Code Artifact KMS. Must be unique."
  type        = string
  default = "kms-codeartifact"
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}
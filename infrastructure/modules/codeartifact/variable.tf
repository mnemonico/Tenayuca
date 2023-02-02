variable "codeartifact_domain" {
  description = "Name of the Code Artifact domain. Must be unique."
  type        = string
  default = "vanilla"
}

variable "codeartifact_repo" {
  description = "Name of the Code Artifact repo. Must be unique."
  type        = string
  default = "vanilla-repo"
}

variable "codeartifact_key" {
  description = "Code Artifact KMS key arn"
  type        = string
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}


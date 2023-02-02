resource "aws_kms_key" "codeartifact" {
  description             = "KMS key for CodeArtifact Repositories"
  key_usage               = "ENCRYPT_DECRYPT"
  deletion_window_in_days = 10
  is_enabled              = true
  enable_key_rotation     = true

  tags  = {
    Customer  = local.Customer
    Provision = local.Provision
    Project = local.project_name
    Name      = "kms-codeartifact"
    Billing   = "No"
  }
}

resource "aws_kms_alias" "codeartifact" {
  name          = "alias/kms-codeartifact"
  target_key_id = aws_kms_key.codeartifact.key_id
}

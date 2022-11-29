data "terraform_remote_state" "terraform" {
  backend = "s3"

  config = {
    bucket  = var.bootstrap_bucket # Reference bucket for terraform state
    key     = var.bootstrap_bucket_key
    region  = var.region
  }
}
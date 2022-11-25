locals {
  project_id = var.project.project_id
  project_name = var.project.project_id

  ecr_repositories          = []

  #bootstrap_bucket  = var.terraform_bucket.bootstrap_bucket
  #bootstrap_bucket_key = var.terraform_bucket.bootstrap_bucket_key
  #infrastructure_bucket_key = var.terraform_bucket.infrastructure_bucket_key

  common_tags = {
    Project   = local.project_name
    Customer  = var.project.customer
    Provision = var.project.provision
  }
}
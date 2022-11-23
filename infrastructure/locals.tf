locals {
  project_id = "lab-simulation-v1"
  project_name = "Lab Simulation Terraform"
  Customer              = "N/A"
  Provision             = "Terraform"

  ecr_repositories          = []

  common_tags = {
    Project   = local.project_name
    Customer  = "N/A"
    Provision = "Terraform"
  }
}
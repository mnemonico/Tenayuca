terraform_bucket = {
  bootstrap_bucket = "lab-simulation-terraform"
  bootstrap_bucket_key = "bootstrap/terraform.tfstate"
  infrastructure_bucket_key = "infrastructure/terraform.tfstate"
  region  = "eu-central-1"
}

project = {
  project_id = "lab-simulation-v1"
  project_name = "Lab Simulation Terraform"
  customer = null
  provision = "Terraform"
}

codepipeline_project_name = "tf-codepipeline-project"
codebuild_project_name = "tf-codebuild-project"
environment = "dev"
source_repo_name   = "mnemonico/cholula"
source_repo_branch = "main"
# create_new_repo    = false
# repo_approvers_arn = "arn:aws:sts::123456789012:assumed-role/CodeCommitReview/*" #Update ARN (IAM Role/User/Group) of Approval Members
# create_new_role    = true
stage_input = [
  { name = "install", category = "Build", owner = "AWS", provider = "CodeBuild", input_artifacts = "SourceOutput", output_artifacts = "InstallOutput" },
  { name = "test", category = "Test", owner = "AWS", provider = "CodeBuild", input_artifacts = "InstallOutput", output_artifacts = "TestOutput" },
  { name = "validate", category = "Test", owner = "AWS", provider = "CodeBuild", input_artifacts = "TestOutput", output_artifacts = "ValidateOutput" }
]
build_projects = ["install", "test", "validate"]
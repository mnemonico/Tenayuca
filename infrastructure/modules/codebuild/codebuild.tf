resource "aws_codebuild_project" "codebuild_project_terraform_plan" {
  count = length(var.codebuild_projects)

  name = "${var.codebuild_project_name}-${var.codebuild_projects[count.index]}"
  description   = "Terraform codebuild project"
  build_timeout = "6"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type     = "S3"
    location = var.codebuild_bucket
  }

  environment {
    compute_type                = var.codebuild_compute_type #"BUILD_GENERAL1_SMALL"
    image                       = var.codebuild_image #aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type                        = var.codebuild_type #"LINUX_CONTAINER"
    image_pull_credentials_type = var.codebuild_image_pull_credentials_type #"CODEBUILD"

    environment_variable {
      name  = "CHOLULA"
      value = "0.0.1"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${var.codebuild_bucket}/${var.codebuild_project_name}/build-log"
    }
  }

  source {
    type      = var.codebuild_project_source
    buildspec = "./templates/stages/${var.codebuild_projects[count.index]}.yml"
  }

  tags = {
    Terraform = "true"
  }
}
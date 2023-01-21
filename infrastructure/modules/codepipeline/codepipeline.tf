resource "aws_codepipeline" "codepipeline" {
  name     = var.codepipeline_project_name
  role_arn = aws_iam_role.codepipeline_role.arn
  tags = var.tags

  artifact_store {
    location = var.codepipeline_bucket
    type     = "S3"

    encryption_key {
      id = data.terraform_remote_state.terraform.outputs.kms-s3
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["SourceOutput"]

      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.github_codepipeline.arn
        #Owner  = "AWS"
        FullRepositoryId = var.repo_name
        BranchName       = var.repo_branch
      }
    }
  }

    dynamic "stage" {
    for_each = var.stages

    content {
      name = "Stage-${stage.value["name"]}"
      action {
        category         = stage.value["category"]
        name             = "Action-${stage.value["name"]}"
        owner            = stage.value["owner"]
        provider         = stage.value["provider"]
        input_artifacts  = [stage.value["input_artifacts"]]
        output_artifacts = [stage.value["output_artifacts"]]
        version          = "1"
        run_order        = index(var.stages, stage.value) + 2

        configuration = {
          ProjectName = stage.value["provider"] == "CodeBuild" ? "${var.codepipeline_project_name}-${stage.value["name"]}" : null
        }
      }
    }
  }
}
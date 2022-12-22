resource "aws_codestarconnections_connection" "github" {
  name          = "mnemonico-connection"
  provider_type = "GitHub"
  tags = var.tags
}

# The CodePipeline GitHub version 1 action provider is deprecated.
#locals {
#  token_username = "mnemonico"
#  webhook_secret = "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"
#}
#
#resource "aws_codepipeline_webhook" "codepipeline_webhook" {
#  name            = "test-webhook-github-bar"
#  authentication  = "GITHUB_HMAC"
#  target_action   = "Source"
#  target_pipeline = aws_codepipeline.codepipeline.name
#
#  authentication_configuration {
#    secret_token = local.webhook_secret
#  }
#
#  filter {
#    json_path    = "$.ref"
#    match_equals = "refs/heads/{Branch}"
#  }
#}
#
## Wire the CodePipeline webhook into a GitHub repository.
#resource "github_repository_webhook" "github_repo_webhook" {
#  repository = var.repo_name
#
#
#  configuration {
#    url          = aws_codepipeline_webhook.codepipeline_webhook.url
#    content_type = "json"
#    insecure_ssl = true
#    secret       = local.webhook_secret
#  }
#
#  events = ["push"]
#}
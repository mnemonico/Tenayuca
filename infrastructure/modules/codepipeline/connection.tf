resource "aws_codestarconnections_connection" "github" {
  name          = "mnemonico-connection"
  provider_type = "GitHub"
}
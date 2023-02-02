resource "aws_codeartifact_domain" "code_artifact_domain" {
  domain         = var.codeartifact_domain
  encryption_key = var.codeartifact_key
}

resource "aws_codeartifact_repository" "simulation_repository" {
  depends_on = [aws_codeartifact_domain.code_artifact_domain]
  repository = var.codeartifact_repo
  domain     = aws_codeartifact_domain.code_artifact_domain.domain

  external_connections {
    external_connection_name = "public:pypi"
  }
}
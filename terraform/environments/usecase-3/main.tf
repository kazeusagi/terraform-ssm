# OIDC: CI/CDからAssumeRoleする際の権限等の設定
module "iam_oidc_provider" {
  source                      = "../../modules/oidc/provider"
  allowed_github_repositories = ["repo:HC-Produce/edinet-scraper:environment:dev"]
  allow_ssm                   = true
}

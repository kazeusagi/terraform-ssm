# OIDC: CI/CDからAssumeRoleする際の権限等の設定
module "iam_oidc_provider" {
  source                      = "../../modules/oidc/provider"
  allowed_github_repositories = ["repo:HC-Produce/edinet-scraper:environment:dev"]
  allow_ssm                   = true
}



# Github Actions Environment
## dev
module "github_env_dev" {
  source = "../../modules/github/env"
  name   = "dev"
  secrets = {
    ASSUME_ROLE_ARN = module.iam_oidc_provider.role_arn
    INSTANCE_ID     = data.terraform_remote_state.usecase_1.outputs.instance_id
  }
  variables = {
    AWS_REGION = "ap-northeast-1"
  }
}

## prod
module "github_env_prod" {
  source = "../../modules/github/env"
  name   = "prod"
  secrets = {
    ASSUME_ROLE_ARN = module.iam_oidc_provider.role_arn
    INSTANCE_ID     = data.terraform_remote_state.usecase_1.outputs.instance_id
  }
  variables = {
    AWS_REGION = "ap-northeast-1"
  }
}

# IDプロバイダ
resource "aws_iam_openid_connect_provider" "main" {
  url            = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
}



# IDプロバイダに割り当てるロール: AssumeRoleの許可設定を行う
module "iam_oidc_role" {
  source                      = "../role"
  name                        = "GithubActionsOIDCRole"
  iam_oidc_provider_arn       = aws_iam_openid_connect_provider.main.arn
  allowed_github_repositories = var.allowed_github_repositories
}



# SSMへの最小権限のポリシー
module "iam_oidc_policy_ssm" {
  count  = var.allow_ssm ? 1 : 0
  source = "../policy/ssm"
  name   = "GithubActionsOIDCRole_SSMPolicy"
}



# ポリシーをロールにアタッチ
resource "aws_iam_role_policy_attachment" "ssm" {
  count      = var.allow_ssm ? 1 : 0
  role       = module.iam_oidc_role.name
  policy_arn = module.iam_oidc_policy_ssm[0].arn
}

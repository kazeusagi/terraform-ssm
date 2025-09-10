# リポジトリの許可設定等を定義したカスタム信頼ポリシー
data "aws_iam_policy_document" "assume_role" {
  # Github Actionsからの信頼ポリシー
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    # フェデレーション認証（外部の認証プロバイダー）を使用
    principals {
      type        = "Federated"
      identifiers = [var.iam_oidc_provider_arn]
    }
    # aud を見て aws 向けに発行されたトークンであることを確認
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
    # sub を見て許可されているリポジトリであることを確認
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = var.allowed_github_repositories
    }
  }
}

# リポジトリの許可設定等を定義したカスタム信頼ポリシー
data "aws_iam_policy_document" "assume_role" {
  # Github Actionsからの信頼ポリシー
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [var.iam_oidc_provider_arn]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = var.allowed_github_repositories
    }
  }
}

# 各環境のロールへのAssumeRoleを許可する許可ポリシーを作成して付与
resource "aws_iam_policy" "main" {
  name   = var.name
  policy = data.aws_iam_policy_document.main.json
}

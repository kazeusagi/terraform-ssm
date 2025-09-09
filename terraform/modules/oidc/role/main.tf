# カスタム信頼ポリシーを設定してロールを作成
# MEMO: カスタム信頼ポリシーはロールに直接定義されるため作成されない
resource "aws_iam_role" "main" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

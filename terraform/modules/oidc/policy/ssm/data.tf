# SSMへの最小権限ポリシー
data "aws_iam_policy_document" "main" {
  statement {
    effect = "Allow"
    actions = [
      "ssm:SendCommand",
      "ssm:GetCommandInvocation"
    ]
    resources = ["*"]
  }
}

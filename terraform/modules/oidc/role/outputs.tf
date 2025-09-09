output "arn" {
  value       = aws_iam_role.main.arn
  description = "ロールのARN"
}

output "name" {
  value = aws_iam_role.main.name
}

output "arn" {
  value       = aws_iam_openid_connect_provider.main.arn
  description = "OIDCプロバイダーのARN"
}

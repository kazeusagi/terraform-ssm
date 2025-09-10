output "role_arn" {
  value       = module.iam_oidc_role.arn
  description = "OIDCプロバイダーのARN"
}

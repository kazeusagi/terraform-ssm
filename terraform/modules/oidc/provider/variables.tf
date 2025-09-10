variable "allowed_github_repositories" {
  description = "許可するGithubリポジトリの一覧"
  type        = list(string)
}

variable "allow_ssm" {
  description = "SSMを許可するか"
  type        = bool
  default     = false
}

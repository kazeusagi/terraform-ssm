terraform {
  required_version = ">= 1.13"

  # hashicorp/github がデフォルトで設定されているため、integrations/github を設定する
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

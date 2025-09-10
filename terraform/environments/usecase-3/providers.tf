provider "aws" {
  region  = "ap-northeast-1"
  profile = "admin"

  default_tags {
    tags = {
      Environment = "usecase-3"
      Project     = "TerraformSMM"
      ManagedBy   = "terraform"
    }
  }
}

provider "github" {
  # token = $GITHUB_TOKEN
  # owner = $GITHUB_OWNER
}

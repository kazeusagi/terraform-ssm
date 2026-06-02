provider "aws" {
  region  = "ap-northeast-1"
  profile = "ssm"

  default_tags {
    tags = {
      Environment = "usecase-1"
      Project     = "TerraformSMM"
      ManagedBy   = "terraform"
    }
  }
}

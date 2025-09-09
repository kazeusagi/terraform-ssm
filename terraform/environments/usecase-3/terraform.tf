terraform {
  required_version = ">= 1.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  cloud {
    organization = "Kazeusagi"
    workspaces {
      name = "TerraformSSM_usecase-3"
    }
  }
}

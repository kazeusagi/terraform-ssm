data "terraform_remote_state" "usecase_1" {
  backend = "remote"

  config = {
    organization = "Kazeusagi"
    workspaces = {
      name = "TerraformSSM_usecase-1"
    }
  }
}

# Environmentの作成
resource "github_repository_environment" "main" {
  repository  = data.github_repository.main.name
  environment = var.name
}

# Secretの作成
resource "github_actions_environment_secret" "main" {
  for_each        = var.secrets
  repository      = data.github_repository.main.name
  environment     = github_repository_environment.main.environment
  secret_name     = each.key
  plaintext_value = each.value
}

# Variableの作成
resource "github_actions_environment_variable" "main" {
  for_each      = var.variables
  repository    = data.github_repository.main.name
  environment   = github_repository_environment.main.environment
  variable_name = each.key
  value         = each.value
}

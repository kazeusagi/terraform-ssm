variable "name" {
  description = "名前"
  type        = string
}

variable "secrets" {
  description = "作成するシークレットのマップ"
  type        = map(string)
}

variable "variables" {
  description = "作成するの変数のマップ"
  type        = map(string)
}
